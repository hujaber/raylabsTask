//
//  AppDelegate.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootController: UINavigationController!
    private var appCoordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        rootController = .init()
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.backgroundColor = .white
        setupCoordinator()
    }
    
    private func setupCoordinator() {
        appCoordinator = ApplicationCoordinator(navigationController: rootController)
        appCoordinator.start()
        window?.makeKeyAndVisible()
    }

}

