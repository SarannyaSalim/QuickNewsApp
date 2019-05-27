//
//  VehicleViewModel.swift
//  AdvancedSwift
//
//  Created by Sarannya on 07/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

//import Foundation
import UIKit



class NewsItemViewModel : NSObject {
    private var newsItem : News{
        didSet{
            
        }
    }

    init(news : News) {
        self.newsItem = news
    }
    
    
    func title() -> String{
        return self.newsItem.title
    }
    
    func storyDescription() -> String{
        
        return self.newsItem.description
    }
    
    func content() -> String?{
        return self.newsItem.content
    }
    
    func time() -> String{
        //TODO: handle nil and ""
        
        if self.newsItem.time.isEmpty{
            return "now"
        }
                var newsTime = self.newsItem.time.replacingOccurrences(of: "T", with: " ")
                newsTime = newsTime.replacingOccurrences(of: "Z", with: "")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        
                guard let formatedStartDate = dateFormatter.date(from: newsTime) else {
                    return "now"
                }
        
        return formatedStartDate.timeAgoForDisplay()
    }
    
    
    func newsUrl() -> URL?{
        return URL(string: self.newsItem.newsUrl)
    }
    
    func sourceName() -> String{
        return self.newsItem.source.name
    }
    
    
    func storyImage(imageView : CustomImageView){
        
        if !self.newsItem.imageUrl.isEmpty {
            
            //default image
            imageView.image = UIImage(named: "newsIcon")
            
            imageView.loadImageFromUrl(urlString: self.newsItem.imageUrl) { response in
                
                switch response {
                case .success(_):
                        break
                case .failure(_):
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "newsIcon")
                    }
                    break
                }
            }
        }
    }
}


//MARK:- Date extension to display timeAgo (days and hours only)

/*** Reference https://stackoverflow.com/questions/40075850/swift-3-find-number-of-calendar-days-between-two-dates ***/

extension Date {
    func timeAgoForDisplay()->String {
        
        let timeNow = Date()
        let components = Set<Calendar.Component>([.hour, .day])
        let interval = Calendar.current.dateComponents(components, from: self, to: timeNow)
        
        guard let day = interval.day else {return ""}
        
        if (day > 0){
            switch day {
            case 1:
                return "1 day ago"
            case 7..<13:
                return "1 week ago"
            case 14..<28 :
                return "\(Int(day/7)) weeks ago"
            default:
                return "\(day) days ago"
            }
        }else{
            guard let hour = interval.hour else{
                return ""
            }
            switch hour {
            case 0:
                return "now"
            default:
                return "\(hour) hrs ago"
            }
        }
    }
    
}
