//
//  MainViewModel.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

final class MainViewModel {
    
    private let apiClient: MainViewApiClient
    private var users: [User] = [] {
        didSet {
            onSuccessfulUserFetch?(users)
        }
    }
    
    // MARK: Callbacks
    var isLoading: ((Bool) -> Void)?
    var onSuccessfulUserFetch: (([User]) -> Void)?
    var onError: ((APIError) -> Void)?

    init(with apiClient: MainViewApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsers() {
        isLoading?(true)
        apiClient.fetchUsers { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading?(false)
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
}
