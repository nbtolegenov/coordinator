//
//  CompositeAppDelegateConfigurator.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

typealias AppDelegateConfigurator = UIResponder & UIApplicationDelegate

final class CompositeAppDelegateConfigurator: AppDelegateConfigurator {
    private let configurators: [AppDelegateConfigurator]

    init(configurators: [AppDelegateConfigurator]) {
        self.configurators = configurators
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configurators.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
}
