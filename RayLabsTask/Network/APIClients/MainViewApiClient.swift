//
//  MainViewApiClient.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

protocol MainViewApiClient {
    func fetchUsers(result: @escaping (Result<[User], APIError>) -> Void)
}

extension APIClient: MainViewApiClient {
    
    func fetchUsers(result: @escaping (Result<[User], APIError>) -> Void) {
        let request = FetchUserRequest()
        genericRequest(for: request, type: UsersResponse.self) { (result_) in
            switch result_ {
            case .success(let userResponse):
                result(.success(userResponse.data))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
