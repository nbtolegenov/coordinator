//
//  AppDelegate.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let configurator: AppDelegateConfigurator = CompositeAppDelegateConfigurator(configurators: [
        UiAppDelegateConfigurator()
    ])
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = configurator.application?(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}
