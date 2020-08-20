//
//  UiAppDelegateConfigurator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

final class UiAppDelegateConfigurator: AppDelegateConfigurator {
    var window: UIWindow?
    
    private lazy var applicationCoordinator = ApplicationCoordinator(
        router: Router(navigationController: window!.rootViewController as! UINavigationController),
        coordinatorFactory: CoordinatorFactory()
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        applicationCoordinator.start()
        return true
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
    }
}
