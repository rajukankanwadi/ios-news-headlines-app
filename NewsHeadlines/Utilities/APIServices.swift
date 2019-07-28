//
//  APIServices.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation

class APIServices {

    class func makeGetCall(onSuccess success: @escaping (_ headlinesData: HeadlinesInfo?) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {

        let headlinesUrl: String = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d960b0b9213f439ba3c7aef8925ab711"
        guard let url = URL(string: headlinesUrl) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in

            guard error == nil else {
                failure(error)
                return
            }

            guard let responseData = data else {
                print("Error did not receive data")
                failure(NSError(domain: "Server", code: 100, userInfo: nil))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let headlines = try? decoder.decode(HeadlinesInfo.self, from: responseData)
                success(headlines)
            }
        }
        task.resume()
    }
}
