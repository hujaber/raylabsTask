//
//  ImageDownloadRequest.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation


struct ImageDownloadRequest: Request {
    var path: String
    
    var dataType: DataType {
        .Data
    }
}
