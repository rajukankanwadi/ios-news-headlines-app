//
//  APIServices.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

internal let globalRealmIdentifier = "BYJUSRealmIdentifier"
class APIServices {

    static let shared = APIServices(baseURL: URL(string: Constants.URL().headLinesUrl)!, realmIdentifier: globalRealmIdentifier)

    private init(baseURL: URL, realmIdentifier: String) {
        self.baseURL = baseURL
        self.realmIdentifier = realmIdentifier
    }

    let baseURL: URL
    let realmIdentifier: String

    func getTopHeadlinesCall(onFailure failure: @escaping (_ error: Error?) -> Void) {

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
                let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.realmIdentifier))
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let headlines = try? decoder.decode(HeadlinesInfo.self, from: responseData) else {return}
                try realm?.write {
                    realm?.create(HeadlinesInfo.self, value: headlines, update: .all)
                }
            } catch let error{
                failure(error)
            }
        }
        task.resume()
    }
}



protocol RealmConsumer: class {
    /// A lazy-instantiated Realm object, which is used to perform realm db operation
    var lazyRealm: Realm? { get }
}
class BaseTableViewController: UITableViewController, RealmConsumer {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    lazy var lazyRealm: Realm? = {
        do {
            return try Realm(configuration: Realm.Configuration(inMemoryIdentifier: globalRealmIdentifier))
        } catch let error {
            return nil
        }
    }()
}

