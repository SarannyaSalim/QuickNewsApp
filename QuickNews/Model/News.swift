//
//  News.swift
//  QuickNews
//
//  Created by Sarannya on 13/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:AnyObject]
struct News{
    let source : Source
    let title : String
    let description : String
    let content : String
    let time : String
    let newsUrl : String
    let imageUrl : String

    init(dictionary:JSONDictionary) {
        
            let id = dictionary["source"]?["id"] as? String
            let name = dictionary["source"]?["name"] as? String
            let title = dictionary["title"] as? String
            let description = dictionary["description"] as? String
            let content = dictionary["content"] as? String
            let time = dictionary["publishedAt"] as? String
            let newsUrl = dictionary["url"] as? String
            let imageUrl = dictionary["urlToImage"] as? String
        
        
        self.source = Source(id: id ?? "", name: name ?? "")
        self.title = title ?? ""
        self.description = description ?? ""
        self.content = content ?? ""
        self.time = time ?? ""
        self.newsUrl = newsUrl ?? ""
        self.imageUrl = imageUrl ?? ""
    }
}

struct Source {
    let id : String
    let name : String
}

struct Articles {
    let articleList : [News]?
    let totalArticles : Int?
}

extension Articles : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Articles, ErrorResult> {
        
        let status = dictionary["status"] as! String
        if status == "error" {
            return Result.failure(ErrorResult.network(string: "maximum limit reached for free account"))
        }

        let count = dictionary["totalResults"] as! Int
        if let data = dictionary["articles"] as? [[String:AnyObject]]{
            
            guard data.count > 0 else {
                return Result.failure(ErrorResult.parser(string: "No vehicle Details"))
            }
            
            var articles : [News] = []
            articles = data.compactMap(News.init)
            
            if articles.count == data.count {
                
                return Result.success(Articles(articleList: articles, totalArticles: count))
                
            }else{
                return Result.failure(ErrorResult.parser(string: "Unable to parse all Vehicle Model"))
            }
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse Vehicle Model"))
        }
        
    }
    
}
