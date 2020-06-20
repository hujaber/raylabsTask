//
//  APIClient.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

class APIClient {
    // this works only for GET requests till now, which is the scope of the app
    func genericRequest<T: Codable>(for request: Request, type: T.Type,
                                    result: @escaping (Result<T, APIError>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: request.path) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        // TODO: - handle POST case
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(.requestError(error.localizedDescription)))
            }
            
           
            
            guard let data = data else {
                result(.failure(.unknown))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                result(.failure(.unknown))
                return
            }
            
            
            
            switch httpResponse.statusCode {
            case 200:
                if request.dataType == .Data {
                    result(.success(data as! T))
                    return
                } else {
                    do {
                        let decodedJson = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            result(.success(decodedJson))
                        }
                    } catch {
                        result(.failure(.jsonDecodingFailure))
                    }
                }
                
            case 404:
                result(.failure(.notFound))
            case 400...499:
                result(.failure(.clientError))
            case 500...599:
                result(.failure(.serverError))
            default:
                result(.failure(.unknown))
            }
        }
        task.resume()
    }
    
}

