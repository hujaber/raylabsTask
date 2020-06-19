//
//  ApplicationCoordinator.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var rootController: UINavigationController
    
    func start() {
        showMainController()
    }
    
    required init(navigationController: UINavigationController) {
        self.rootController = navigationController
        self.rootController.navigationBar.prefersLargeTitles = true
    }
    
    private func showMainController() {
        let controller = ControllerFactory.makeMainController()
        setRootController(controller, animated: false)
    }
    
}
