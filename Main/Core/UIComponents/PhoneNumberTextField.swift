//
//  PhoneNumberTextField.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

final class PhoneNumberTextField: UITextField {
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 56)
    }
    
    private let formatter: PhoneNumberFormatter = PropertyFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(origin: .zero, size: CGSize(width: 16, height: bounds.height))
    }

    override func deleteBackward() {
        guard let text = text, text.count > Constants.codePrefix.count else { return }
        if let digits = formatter.digits(from: text) {
            self.text = formatter.formattedPhoneNumber(from: String(digits.dropLast()))
        } else {
            self.text?.removeLast()
        }
        sendActions(for: .editingChanged)
    }

    private func setup() {
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidChange), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        backgroundColor = .clear
        borderStyle = .none
        delegate = self
        font = .systemFont(ofSize: 16)
        keyboardType = .numberPad
        layer.borderColor = UIColor.systemFill.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        leftView = UIView()
        leftViewMode = .always
        placeholder = "Phone number"
        textContentType = .telephoneNumber
        tintColor = .label
    }

    @objc
    private func editingDidBegin() {
        guard let text = text, text.isEmpty else { return }
        self.text = Constants.codePrefix
        sendActions(for: .editingChanged)
    }

    @objc
    private func editingDidChange() {
        guard isEditing,
            let digits = formatter.digits(from: text ?? "") else { return }
        text = formatter.formattedPhoneNumber(from: digits)
        if (text ?? "").count < Constants.codePrefix.count {
            text = Constants.codePrefix
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
        }
    }

    @objc
    private func editingDidEnd() {
        guard let text = text, text.trimmingCharacters(in: .whitespacesAndNewlines) == Constants.codePrefix else { return }
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

extension PhoneNumberTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isBackspace,
            let text = text,
            let range = Range(range, in: text),
            let currentDigits = formatter.digits(from: text.replacingCharacters(in: range, with: "")),
            let newDigits = formatter.digits(from: string) else { return true }
        self.text = currentDigits + String(newDigits.suffix(max(0, Constants.digitsCount - currentDigits.count)))
        sendActions(for: .editingChanged)
        return false
    }
}

private extension String {
    var isBackspace: Bool {
        guard let char = cString(using: .utf8) else { return false }
        return strcmp(char, "\\b") == -92
    }
}

private enum Constants {
    static let codePrefix = "+7"
    static let digitsCount = 11
}
