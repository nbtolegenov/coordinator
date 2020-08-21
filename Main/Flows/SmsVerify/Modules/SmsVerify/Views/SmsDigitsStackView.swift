//
//  SmsDigitsStackView.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

protocol SmsDigitsStackViewDelegate: class {
    func smsDigitsStackView(_ view: SmsDigitsStackView, didChangeCode code: String)
}

final class SmsDigitsStackView: UIStackView {
    weak var delegate: SmsDigitsStackViewDelegate?

    var code: String {
        get { aggregateCodeFromTextFields() }
        set { updateDigitTextFields(with: newValue) }
    }

    private lazy var digitTextFields: [SmsDigitTextField] = (0 ..< 4).map { _ in
        let textField = SmsDigitTextField()
        textField.addTarget(self, action: #selector(editingDidChangeTextField), for: .editingChanged)
        textField.deleteDelegate = self
        return textField
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        guard code.count < digitTextFields.count else { return false }
        return digitTextFields[code.count].becomeFirstResponder()
    }

    private func aggregateCodeFromTextFields() -> String {
        digitTextFields.reduce("") { $0 + ($1.text ?? "") }
    }

    private func updateDigitTextFields(with code: String) {
        digitTextFields.forEach { $0.text = "" }
        for (index, digit) in code.enumerated() {
            digitTextFields[index].text = String(digit)
        }
    }

    @objc
    private func editingDidChangeTextField(_ textField: SmsDigitTextField) {
        digitTextFields.forEach { $0.text = String(($0.text ?? "").suffix(1)) }
        becomeFirstResponder()
        delegate?.smsDigitsStackView(self, didChangeCode: code)
    }

    private func setup() {
        distribution = .fillEqually
        spacing = 16
        digitTextFields.forEach { addArrangedSubview($0) }
    }
}

extension SmsDigitsStackView: SmsDigitTextFieldDeleteDelegate {
    func smsDigitTextFieldDidTapDelete(_ textField: SmsDigitTextField) {
        activatePreviousTextField(currentTextField: textField)
        textField.text = ""
        delegate?.smsDigitsStackView(self, didChangeCode: code)
    }

    private func activatePreviousTextField(currentTextField textField: SmsDigitTextField) {
        guard let textFieldIndex = digitTextFields.firstIndex(of: textField) else { return }
        if textFieldIndex - 1 >= 0, (textField.text ?? "").isEmpty {
            digitTextFields[textFieldIndex - 1].text = ""
            digitTextFields[textFieldIndex - 1].becomeFirstResponder()
        }
    }
}
