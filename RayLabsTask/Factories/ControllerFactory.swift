//
//  ControllerFactory.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

class ControllerFactory {
    private init() {}
    
    static func makeMainController() -> MainController {
        let apiClient: MainViewApiClient = APIClient()
        let viewModel = MainViewModel(with: apiClient)
        let mainController = MainController(with: viewModel)
        mainController.navigationItem.largeTitleDisplayMode = .always
        return mainController
    }
}
