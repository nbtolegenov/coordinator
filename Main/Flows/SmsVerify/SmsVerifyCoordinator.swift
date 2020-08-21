//
//  SmsVerifyCoordinator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol SmsVerifyCoordinatorOutput: class {
    var onClose: (() -> Void)? { get set }
    var onFinish: ((VerifySmsResponse) -> Void)? { get set }
}

final class SmsVerifyCoordinator: Coordinator, SmsVerifyCoordinatorOutput {
    var onClose: (() -> Void)?
    var onFinish: ((VerifySmsResponse) -> Void)?
    
    private let inputParameters: SmsVerifyInputParameters
    private let moduleFactory: SmsVerifyModuleFactory
    
    init(router: Router, inputParameters: SmsVerifyInputParameters, moduleFactory: SmsVerifyModuleFactory) {
        self.inputParameters = inputParameters
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }
    
    override func start() {
        presentSmsVerify()
    }
    
    private func presentSmsVerify() {
        let smsVerify = moduleFactory.makeSmsVerify(inputParameters: inputParameters)
        smsVerify.onSmsVerifyFinish = { [weak self] response in
            self?.onFinish?(response)
        }
        router.push(smsVerify) { [weak self] in
            self?.onClose?()
        }
    }
}
