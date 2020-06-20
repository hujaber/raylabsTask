//
//  User.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    let data: [User]
}

struct User: Codable {
    let id: Int
    let firstName, lastName, email: String
    let imageURL: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case imageURL = "image_url"
        case latitude, longitude
    }
    
    var hasLocation: Bool {
        (latitude != nil) && (longitude != nil)
    }
    
    var fullname: String {
        "\(firstName) \(lastName)"
    }
}

