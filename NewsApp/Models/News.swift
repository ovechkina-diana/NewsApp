//
//  News.swift
//  NewsApp
//
//  Created by Diana Ovechkina on 20.01.2022.
//

import Foundation

struct Article: Codable {
    let status: String
    let articles: [New]
}


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
}

enum Link: String {
    case NewsApi = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7458a17ff5db4185ab6506339cf8beec"
}
