//
//  ApplicationCoordinator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }
    
    override func start() {
        runAuthFlow()
    }
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuth(router: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
