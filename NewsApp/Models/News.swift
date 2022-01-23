//
//  News.swift
//  NewsApp
//
//  Created by Diana Ovechkina on 20.01.2022.
//

import Foundation

//struct Article: Codable {
//    let status: String
//    let articles: [New]
//}


struct New: Codable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let content: String
    
    var fullDescription: String {
        """
        Author: \(author)
        Title: \(title)
        Description: \(description)
        Content: \(content)
        """
    }
    
    init(newData: [String: Any]) {
        author = newData["author"] as? String ?? ""
        title = newData["title"] as? String ?? ""
        description = newData["description"] as? String ?? ""
        url = newData["url"] as? String ?? ""
        urlToImage = newData["urlToImage"] as? String ?? ""
        content = newData["content"] as? String ?? ""
    }
    
    static func getNews(from value: Any) -> [New] {
        guard let articleData = value as? [String:Any] else { return [] }
        guard let newsData = articleData["articles"] as? [[String: Any]] else { return [] }
        
        return newsData.map {New(newData: $0)}
    }
    
//    static func getNews(from value: Any) -> [New] {
//        guard let articleData = value as? [String:Any] else { return [] }
//        guard let newsData = articleData["articles"] as? [[String: Any]] else { return [] }
//        var allNews = [New]()
//        for newData in newsData {
//            let new = New(newData: newData)
//            allNews.append(new)
//        }
//        return allNews
//    }
}

enum Link: String {
    case NewsApi = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7458a17ff5db4185ab6506339cf8beec"
}
