//
//  SignInViewController.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

protocol SignInView: BaseView {
    var onSignInFinish: ((String, SignInResponse) -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
}

final class SignInViewController: UIViewController, SignInView, NVActivityIndicatorViewable {
    var onSignInFinish: ((String, SignInResponse) -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    
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
        title = "Sign In"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @IBAction
    private func signInButtonDidTap() {
        view.endEditing(true)
        startAnimating()
        provider.signIn(phoneNumber: phoneNumber).then { [weak self] response in
            guard let self = self else { return }
            self.onSignInFinish?(self.phoneNumber, response)
        }.always { [weak self] in
            self?.stopAnimating()
        }
    }
    
    @IBAction
    private func signUpButtonDidTap() {
        onSignUpButtonTap?()
    }
}

