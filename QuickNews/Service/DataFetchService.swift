//
//  DataFetchService.swift
//  AdvancedSwift
//
//  Created by Sarannya on 10/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import Foundation

protocol DataFetchServiceProtocol : class{
    
    func fetchDatafromServer(fromPage number : Int, _ completion: @escaping ((Result<Articles, ErrorResult>) -> Void))
}

final class NewsFetchService : ResponseHandler, DataFetchServiceProtocol{

    static let shared = NewsFetchService()
    
    let dateToday = Date()
    
    var task : URLSessionTask?
    
    func fetchDatafromServer(fromPage number : Int, _ completion: @escaping ((Result<Articles, ErrorResult>) -> Void)) {
        
        let key = "bd05112cec824209913198a603d414c6"
        let pageSize = 21
        let endpoint = "https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=\(key)&page=\(number)&pageSize=\(pageSize)"
        
        self.cancelPreviousTask()
        
         task = RequestService(session: URLSession(configuration: .default)).requestDataFromServer(urlstring: endpoint, completion: self.networkResponse(completion: completion))
        
    }
    
    func cancelPreviousTask(){
        if let task = task{
            task.cancel()
        }
        task = nil
    }
}
