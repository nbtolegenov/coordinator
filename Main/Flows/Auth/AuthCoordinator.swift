//
//  AuthCoordinator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol AuthCoordinatorOutput: class {
    var onFinish: (() -> Void)? { get set }
}

final class AuthCoordinator: Coordinator, AuthCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    private let coordinatorFactory: CoordinatorFactory
    private let moduleFactory: AuthModuleFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, moduleFactory: AuthModuleFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }
    
    override func start() {
        presentSignIn()
    }
    
    private func presentSignIn() {
        let signIn = moduleFactory.makeSignIn()
        signIn.onSignInFinish = { [weak self] phoneNumber, response in
            self?.runSmsVerifyFlow(inputParameters: .init(phoneNumber: phoneNumber, smsId: response.smsId))
        }
        signIn.onSignUpButtonTap = { [weak self] in
            self?.presentSignUp()
        }
        router.setRootModule(signIn)
    }
    
    private func presentSignUp() {
        let signUp = moduleFactory.makeSignUp()
        signUp.onSignUpFinish = { [weak self] phoneNumber, response in
            self?.runSmsVerifyFlow(inputParameters: .init(phoneNumber: phoneNumber, smsId: response.smsId))
        }
        router.push(signUp)
    }
    
    private func runSmsVerifyFlow(inputParameters: SmsVerifyInputParameters) {
        let coordinator = coordinatorFactory.makeSmsVerify(router: router, inputParameters: inputParameters)
        coordinator.onClose = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        coordinator.onFinish = { [weak self] response in
            print(self ?? "", response)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

