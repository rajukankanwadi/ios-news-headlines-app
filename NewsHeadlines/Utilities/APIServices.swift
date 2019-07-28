//
//  APIServices.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation
typealias SessionSuccessCallBack = (_ response : Any, _ data: Data) -> Void
typealias SessionFailuerCallBack = (_ responseError : String) -> Void

class APIServices {

    func get(url: String, headers: [String:String], success:@escaping SessionSuccessCallBack, failure:@escaping SessionFailuerCallBack) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        for (key, value) in headers {
            request.allHTTPHeaderFields?[key] = value
        }
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                failure((error.localizedDescription))
            } else {
                guard let data = data else { return }
                success(response as Any, data)
            }
        }
        task.resume()
        URLCache.shared.removeAllCachedResponses()
    }

    class func makeGetCall(onSuccess success: @escaping (_ headlinesData: HeadlinesInfo?) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {

        let todoEndpoint: String = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d960b0b9213f439ba3c7aef8925ab711"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        // set up the session
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                failure(error)
                return
            }

            guard let responseData = data else {
                print("Error: did not receive data")
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
