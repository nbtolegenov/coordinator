//
//  SmsVerifyModuleFactory.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol SmsVerifyModuleFactory: class {
    func makeSmsVerify(inputParameters: SmsVerifyInputParameters) -> SmsVerifyView
}

extension ModuleFactory: SmsVerifyModuleFactory {
    func makeSmsVerify(inputParameters: SmsVerifyInputParameters) -> SmsVerifyView {
        SmsVerifyViewController(phoneNumber: inputParameters.phoneNumber,
                                smsId: inputParameters.smsId,
                                provider: NetworkProvider(),
                                formatter: PropertyFormatter())
    }
}
