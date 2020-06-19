//
//  ImageCache.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

protocol LocalImageCache {
    func fetchImageFromCache(imageId: String) -> UIImage?
    func cacheImage(image: UIImage, id: String)
}

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private let apiClient: ImageDownloaderClient = APIClient()
    
    func fetchImage(urlString: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            completion(.success(cachedImage))
        } else {
            apiClient.downloadImage(path: urlString) { [weak self] (result) in
                switch result {
                case .success(let image):
                    self?.cache.setObject(image, forKey: urlString as NSString)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension ImageCache: LocalImageCache {
    func fetchImageFromCache(imageId: String) -> UIImage? {
        return cache.object(forKey: imageId as NSString)
    }
    
    func cacheImage(image: UIImage, id: String) {
        cache.setObject(image, forKey: id as NSString)
    }
}

