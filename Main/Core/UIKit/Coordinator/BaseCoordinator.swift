//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

class Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator,
            !childCoordinators.isEmpty else { return }
        if !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        childCoordinators.removeAll { $0 === coordinator }
    }
}
