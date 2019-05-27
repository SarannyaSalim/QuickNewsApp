//
//  SupportViews.swift
//  QuickNews
//
//  Created by Sarannya on 18/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import UIKit

/***Reference - url for device settings :- https://stackoverflow.com/questions/28152526/how-do-i-open-phone-settings-when-a-button-is-clicked/52103305***/

class SupportViews {
    
    static func CreatNetworkAlert() -> UIAlertController{
        let alertView = UIAlertController(title: "Network!\n", message: "Please check your network settings", preferredStyle: .alert)
        let action = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }
        alertView.addAction(action)
        alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        return alertView
    }
}



//MARK:- CustomImageView
/*******************************************************************************/

let imageCache = NSCache<AnyObject, AnyObject>()
var imageUrlString : String?

class  CustomImageView : UIImageView {
    
    func loadImageFromUrl(urlString : String, completionBlock : @escaping ((Result<Data, ErrorResult>)->Void)){
        
        imageUrlString = urlString
        guard let url = URL(string: urlString) else{
//            print("invalid url")
            completionBlock(Result.failure(.custom(string: "invalid url")))
            return
        }
        image =  nil
        
        if let imageFromCache =  imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
//                print("image load request failed \(error!)")
                completionBlock(Result.failure(.custom(string: "request failed")))
                return
            }
            
            DispatchQueue.main.async {
                
                guard let imageToCache = UIImage(data: data!) else{
                    completionBlock(Result.failure(.custom(string: "corrupted image data")))
                    return
                }

                    if imageUrlString == urlString{
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = UIImage(data: data!)
            }
            }.resume()
        
    }
}

