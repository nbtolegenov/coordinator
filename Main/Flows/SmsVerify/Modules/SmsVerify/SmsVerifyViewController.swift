//
//  SmsVerifyViewController.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

protocol SmsVerifyView: BaseView {
    var onSmsVerifyFinish: ((VerifySmsResponse) -> Void)? { get set }
}

final class SmsVerifyViewController: UIViewController, SmsVerifyView, NVActivityIndicatorViewable {
    var onSmsVerifyFinish: ((VerifySmsResponse) -> Void)?
    
    private let phoneNumber: String
    private let smsId: String
    private let provider: SmsVerifyProvider
    private let formatter: PhoneNumberFormatter

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var digitsStackView: SmsDigitsStackView!

    init(phoneNumber: String, smsId: String, provider: SmsVerifyProvider, formatter: PhoneNumberFormatter) {
        self.phoneNumber = phoneNumber
        self.smsId = smsId
        self.provider = provider
        self.formatter = formatter
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        self.title = "SMS-verification"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        digitsStackView.becomeFirstResponder()
    }
    
    private func setupUi() {
        if let formattedPhoneNumber = formatter.formattedPhoneNumber(from: phoneNumber) {
            titleLabel.text = "SMS sent to \(formattedPhoneNumber)"
        }
        digitsStackView.delegate = self
    }
}

extension SmsVerifyViewController: SmsDigitsStackViewDelegate {
    func smsDigitsStackView(_ view: SmsDigitsStackView, didChangeCode code: String) {
        guard code.count == 4 else { return }
        view.endEditing(true)
        startAnimating()
        provider.verifySms(phoneNumber: phoneNumber, smsId: smsId, code: code).then { [weak self] response in
            self?.onSmsVerifyFinish?(response)
        }.always { [weak self] in
            self?.stopAnimating()
        }
    }
}
