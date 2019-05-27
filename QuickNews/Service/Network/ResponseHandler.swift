//
//  RequestHandler.swift
//  AdvancedSwift
//
//  Created by Sarannya on 10/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//  Referred https://benoitpasquier.com/ios-swift-mvvm-pattern/


import Foundation

class ResponseHandler {
    
    func networkResponse<T:Parceable>(completion : @escaping ((Result<[T], ErrorResult>)->Void))->((Result<Data, ErrorResult>)->Void){
        
        return {   response in
            DispatchQueue.global(qos: .background).async {
                switch response {
                case .success(let data) :
                    ParserHelper.parse(data: data, completion: completion)
                    break
                case .failure(let error) :
//                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
                
            }
            
        }
        
    }
    
    func networkResponse<T:Parceable>(completion : @escaping ((Result<T, ErrorResult>)->Void))->((Result<Data, ErrorResult>)->Void){
        
        return {   response in
            DispatchQueue.global(qos: .background).async {
                switch response {
                case .success(let data) :
                    ParserHelper.parse(data: data, completion: completion)
                    break
                case .failure(let error) :
//                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
                
            }
            
        }
        
    }
}
