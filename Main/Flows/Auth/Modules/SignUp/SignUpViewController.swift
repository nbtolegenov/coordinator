//
//  SignUpViewController.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

protocol SignUpView: BaseView {}

final class SignUpViewController: UIViewController, SignUpView {
    init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        title = "Sign Up"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}
