//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Diana Ovechkina on 20.01.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<New, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let new = try JSONDecoder().decode(New.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(new))
                }
            } catch {
                    completion(.failure(.decodingError))
                }
        }.resume()
    }
    
    func fetchDataWithAlomafirefrom(url: String, completion: @escaping(Result<[New], NetworkError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let allNews = New.getNews(from: value)
                    completion(.success(allNews))
                case .failure:
                    completion(.failure(.decodingError ))
                }
            }
    }
    
//    func fetchData(from url: String?, with completion: @escaping(Article) -> Void) {
//        guard let url = URL(string: url ?? "") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let new = try JSONDecoder().decode(Article.self, from: data)
//                DispatchQueue.main.async {
//                    completion(new)
//                }
//            } catch let error {
//                print(error)
//            }
//
//        }.resume()
//    }
}

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil}
        return try? Data(contentsOf: imageURL)
    }
}
