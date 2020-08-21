//
//  SmsVerifyProvider.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation
import Promises

protocol SmsVerifyProvider {
    func verifySms(phoneNumber: String, smsId: String, code: String) -> Promise<VerifySmsResponse>
}

extension NetworkProvider: SmsVerifyProvider {
    func verifySms(phoneNumber: String, smsId: String, code: String) -> Promise<VerifySmsResponse> {
        Promise(VerifySmsResponse(token: "Token")).delay(1)
    }
}

struct VerifySmsResponse: Decodable {
    let token: String
}
