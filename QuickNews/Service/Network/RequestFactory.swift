//
//  RequestFactory.swift
//  AdvancedSwift
//
//  Created by Sarannya on 10/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//  Referred https://benoitpasquier.com/ios-swift-mvvm-pattern/


import Foundation

final class RequestFactory{
    
    enum Method : String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method : Method, url : URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
