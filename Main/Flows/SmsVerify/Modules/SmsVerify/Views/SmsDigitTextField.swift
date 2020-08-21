//
//  SmsDigitTextField.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

protocol SmsDigitTextFieldDeleteDelegate: class {
    func smsDigitTextFieldDidTapDelete(_ textField: SmsDigitTextField)
}

final class SmsDigitTextField: UITextField {
    weak var deleteDelegate: SmsDigitTextFieldDeleteDelegate?

    override var intrinsicContentSize: CGSize {
        CGSize(width: 40, height: 48)
    }

    override var text: String? {
        didSet {
            updateBottomLayer()
        }
    }

    private let bottomLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomLayer()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

    override func deleteBackward() {
        deleteDelegate?.smsDigitTextFieldDidTapDelete(self)
    }

    private func updateBottomLayer() {
        if let text = text, !text.isEmpty {
            bottomLayer.backgroundColor = UIColor.label.cgColor
        } else {
            bottomLayer.backgroundColor = UIColor.gray.cgColor
        }
        bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }

    private func setup() {
        font = .systemFont(ofSize: 22)
        keyboardType = .numberPad
        layer.addSublayer(bottomLayer)
        textAlignment = .center
        textColor = .label
        tintColor = .label
    }
}
