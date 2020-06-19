//
//  APIError.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

enum APIError: Error {
    case custom(String)
    case networkError
    case requestError(String?)
    case clientError
    case serverError
    case unknown
    case notFound
    case jsonDecodingFailure
}
