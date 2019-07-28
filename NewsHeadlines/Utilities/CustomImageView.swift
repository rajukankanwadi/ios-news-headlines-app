//
//  CustomImageView.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrl(urlString: String) {

        imageUrlString = urlString

        let url = URL(string: urlString)

        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!) { (data, responce, error) in

            if error != nil {
                print(error ?? "")
                return
            }

            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }.resume()
    }
}