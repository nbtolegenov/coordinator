//
//  AuthModuleFactory.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol AuthModuleFactory: class {
    func makeSignIn() -> SignInView
    func makeSignUp() -> SignUpView
}

extension ModuleFactory: AuthModuleFactory {
    func makeSignIn() -> SignInView {
        SignInViewController(provider: NetworkProvider(), formatter: PropertyFormatter())
    }
    
    func makeSignUp() -> SignUpView {
        SignUpViewController(provider: NetworkProvider(), formatter: PropertyFormatter())
    }
}
