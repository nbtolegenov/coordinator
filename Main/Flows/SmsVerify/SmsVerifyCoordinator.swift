//
//  SmsVerifyCoordinator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol SmsVerifyCoordinatorOutput: class {
    var onFinish: ((VerifySmsResponse) -> Void)? { get set }
}

final class SmsVerifyCoordinator: Coordinator, SmsVerifyCoordinatorOutput {
    var onFinish: ((VerifySmsResponse) -> Void)?
    
    private let router: Router
    private let inputParameters: SmsVerifyInputParameters
    private let moduleFactory: SmsVerifyModuleFactory
    
    init(router: Router, inputParameters: SmsVerifyInputParameters, moduleFactory: SmsVerifyModuleFactory) {
        self.router = router
        self.inputParameters = inputParameters
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        presentSmsVerify()
    }
    
    private func presentSmsVerify() {
        let smsVerify = moduleFactory.makeSmsVerify(inputParameters: inputParameters)
        smsVerify.onSmsVerifyFinish = { [weak self] response in
            self?.onFinish?(response)
        }
        router.push(smsVerify)
    }
}
