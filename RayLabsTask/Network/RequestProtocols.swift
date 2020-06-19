//
//  RequestProtocols.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import Foundation

/// protocol to be implemented by any object who wants to issue a network request.
protocol Request {

    /// Relative path of the endpoint we want to call
    var path: String { get }
    /// This define the HTTP method we should use to perform the call
    /// We have defined it inside an String based enum called `HTTPMethod`
    /// just for clarity
    var method: HTTPMethod { get }
    /// You may also define a list of headers to pass along with each request.
    var headers: [String:Any]? { get }
    /// These are the parameters we need to send along with the call.
    /// Params can be passed into the body or along with the URL
    var parameters: RequestParams { get }
    /// What kind of data we expect as response
    var dataType: DataType { get }
    
}

///Request default implementation
extension Request {
    
    var dataType: DataType {
        return .JSON
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [String:Any]? {
        return nil
    }

    var parameters: RequestParams {
        return .noParams
    }
}

/// Define the type of data we expect as response
///
/// - JSON: it's a json
/// - Data: it's plain data (ie. imageData)
enum DataType {
    case JSON
    case Data
}

/// This define the type of HTTP method used to perform the request
///
/// - post: POST method
/// - put: PUT method
/// - get: GET method
/// - delete: DELETE method
/// - patch: PATCH method
enum HTTPMethod: String {
    case post   = "POST"
    case put    = "PUT"
    case get    = "GET"
    case delete = "DELETE"
    case patch  = "PATCH"
}

/// Define parameters to pass along with the request and how
/// they are encapsulated into the http request itself.
///
/// - body: part of the body stream
/// - url: as url parameters
enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
    case noParams
}
