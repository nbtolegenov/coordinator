//
//  Router.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/20/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

final class Router {
    private weak var navigationController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        completions = [:]
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        if #available(iOS 13.0, *) {
            present(module, animated: animated, modalPresentationStyle: .automatic)
        } else {
            present(module, animated: animated, modalPresentationStyle: .fullScreen)
        }
    }
    
    func present(_ module: Presentable?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = modalPresentationStyle
        navigationController?.present(controller, animated: animated)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBarWhenPushed: Bool) {
        push(module, animated: true, hideBottomBarWhenPushed: hideBottomBarWhenPushed, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, completion: (() -> Void)?) {
        push(module, animated: true, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBarWhenPushed: false, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBarWhenPushed: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent(), (controller is UINavigationController == false) else {
            assertionFailure("Deprecated push UINavigationController")
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBarWhenPushed
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controller = navigationController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismissModule(animated: Bool) {
        dismissModule(animated: animated, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, isNavigationBarHidden: false)
    }
    
    func setRootModule(_ module: Presentable?, isNavigationBarHidden: Bool) {
        guard let controller = module?.toPresent() else { return }
        navigationController?.setViewControllers([controller], animated: false)
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
    }
    
    func popToRootModule() {
        popToRootModule(animated: true)
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension Router: Presentable {
    func toPresent() -> UIViewController? {
        navigationController
    }
}
