//
//  CoordinatorFactory.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

final class CoordinatorFactory {
    func makeAuth(router: Router) -> Coordinator & AuthCoordinatorOutput {
        AuthCoordinator(router: router, coordinatorFactory: CoordinatorFactory(), moduleFactory: ModuleFactory())
    }
    
    func makeSmsVerify(router: Router, inputParameters: SmsVerifyInputParameters) -> Coordinator & SmsVerifyCoordinatorOutput {
        SmsVerifyCoordinator(router: router, inputParameters: inputParameters, moduleFactory: ModuleFactory())
    }
}
