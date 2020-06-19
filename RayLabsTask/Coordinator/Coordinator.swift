//
//  Coordinator.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var rootController: UINavigationController { get set }
    
    func start()
    func removeChild(_ child: Coordinator)
    init(navigationController: UINavigationController)
}

extension Coordinator {
    func removeAllChildren() {
        childCoordinators.removeAll()
    }
    
    func removeChild(_ child: Coordinator) {
        childCoordinators.removeAll(where: { $0 === child })
    }
    
    func setRootController(_ controller: UIViewController, animated: Bool = false) {
        rootController.setViewControllers([controller], animated: animated)
    }
    
    func push(_ controller: UIViewController, animated: Bool = true) {
        rootController.pushViewController(controller, animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        rootController.dismiss(animated: animated,
                               completion: completion)
    }
    
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func pop(animated: Bool = true) {
        rootController.popViewController(animated: animated)
    }
    
    func present(_ controller: UIViewController,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) {
        rootController.present(controller,
                               animated: animated,
                               completion: completion)
    }
    
    func popToRoot(animated: Bool = true) {
        rootController.popToRootViewController(animated: animated)
    }
    
    func presentFullScreen(_ controller: UIViewController,
                           animated: Bool = true,
                           completion: (() -> Void)? = nil) {
        controller.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        present(controller, animated: animated, completion: completion)
    }
}

