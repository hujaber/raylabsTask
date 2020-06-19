//
//  ImageDownloader.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

protocol ImageDownloaderClient {
    func downloadImage(path: String, result: @escaping (Result<UIImage, APIError>) -> Void)
}

extension APIClient: ImageDownloaderClient {
    func downloadImage(path: String, result: @escaping (Result<UIImage, APIError>) -> Void) {
        let imageDownloadRequest = ImageDownloadRequest(path: path)
        genericRequest(for: imageDownloadRequest, type: Data.self) { (result_) in
            switch result_ {
            case .failure(let error):
                result(.failure(error))
            case .success(let data):
                if let image = UIImage(data: data) {
                    result(.success(image))
                } else {
                    result(.failure(.custom("Failed to decode image")))
                }
            }
        }
    }
}
