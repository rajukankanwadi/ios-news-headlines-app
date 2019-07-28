//
//  HeadlinesInfo.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//
import Foundation

// MARK: - HeadlinesInfo
class HeadlinesInfo: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }

    init(status: String?, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
class Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }

    init(source: Source?, author: String?, title: String?, articleDescription: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
class Source: Codable {
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}
