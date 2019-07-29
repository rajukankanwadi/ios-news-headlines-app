//
//  HeadlinesInfo.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//
import Foundation
import Realm
import RealmSwift

class CBMAObject: Object, Decodable {

    @objc dynamic var status: String?
    @objc dynamic var totalResults: Int = 0

    private enum ServiceInfoCodingKeys: String, CodingKey {
        case status
        case totalResults
    }

    public required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: ServiceInfoCodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
    }

    required init() {
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}


// MARK: - HeadlinesInfo
final class HeadlinesInfo:CBMAObject {

    var articles = List<Article>()

    override static func primaryKey() -> String? {
        return "status"
    }

    private enum ArticlesInfoCodingKeys: String, CodingKey {
        case articles
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticlesInfoCodingKeys.self)

        if let baseAccounts = try container.decodeIfPresent([Article].self, forKey: .articles) {
            self.articles.append(objectsIn: baseAccounts)
        }
        try super.init(from: decoder)
        print(self.articles)
    }

    required init() {
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

}

// MARK: - Article
final class Article:Object, Codable {
    @objc dynamic var source: Source?
    @objc dynamic var author: String?
    @objc dynamic var title: String?
    @objc dynamic var articleDescription: String?
    @objc dynamic var url: String?
    @objc dynamic var urlToImage: String?
    @objc dynamic var publishedAt: String?
    @objc dynamic var content: String?

    override static func primaryKey() -> String? {
        return "url"
    }
}

// MARK: - Source
final class Source:Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?

    override static func primaryKey() -> String? {
        return "id"
    }

}
