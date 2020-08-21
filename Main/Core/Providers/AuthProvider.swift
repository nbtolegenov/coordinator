//
//  AuthProvider.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation
import Promises

protocol AuthProvider {
    func signIn(phoneNumber: String) -> Promise<SignInResponse>
    func signUp(phoneNumber: String) -> Promise<SignUpResponse>
}

extension NetworkProvider: AuthProvider {
    func signIn(phoneNumber: String) -> Promise<SignInResponse> {
        Promise(SignInResponse(smsId: "1111")).delay(1)
    }
    
    func signUp(phoneNumber: String) -> Promise<SignUpResponse> {
        Promise(SignUpResponse(smsId: "1111")).delay(1)
    }
}

struct SignInResponse: Decodable {
    let smsId: String
}

struct SignUpResponse: Decodable {
    let smsId: String
}
