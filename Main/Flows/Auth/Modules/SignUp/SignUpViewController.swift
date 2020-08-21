//
//  SignUpViewController.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

protocol SignUpView: BaseView {
    var onSignUpFinish: ((String, SignUpResponse) -> Void)? { get set }
}

final class SignUpViewController: UIViewController, SignUpView, NVActivityIndicatorViewable {
    var onSignUpFinish: ((String, SignUpResponse) -> Void)?
    
    private let provider: AuthProvider
    private let formatter: PhoneNumberFormatter
    
    private var phoneNumber: String {
        guard let text = phoneNumberTextField.text,
            let phoneNumber = formatter.rawPhoneNumber(from: text) else { return "" }
        return phoneNumber
    }
    
    @IBOutlet private var phoneNumberTextField: PhoneNumberTextField!
    
    init(provider: AuthProvider, formatter: PhoneNumberFormatter) {
        self.provider = provider
        self.formatter = formatter
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        title = "Sign Up"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @IBAction
    private func signUpButtonDidTap() {
        view.endEditing(true)
        startAnimating()
        provider.signUp(phoneNumber: phoneNumber).then { [weak self] response in
            guard let self = self else { return }
            self.onSignUpFinish?(self.phoneNumber, response)
        }.always { [weak self] in
            self?.stopAnimating()
        }
    }
}
