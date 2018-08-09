//
//  Networking.swift
//  Itunes search
//
//  Created by DeMoN on 08/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import UIKit
import Alamofire

struct ListRequestConfig {
    var searchText = ""
    var filter = SearchType.music
    var limit = Networking.limit
}

enum Networking: URLRequestConvertible {
    
    static let baseURLString = "https://itunes.apple.com"
    static let limit = 50
    
    /// **Parameters:** *(ListRequestConfig)* list parameters
    case search(ListRequestConfig)

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Networking.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .search(let listRequestConfig):
            let parameters = ["term": listRequestConfig.searchText,"entity" : listRequestConfig.filter.rawValue, "country": "us", "limit": listRequestConfig.limit] as [String : AnyObject]
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
    
    static func showNetworkIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    static func hideNetworkIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
