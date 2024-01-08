//
//  NetworkManager.swift
//  client
//
//  Created by 金澤帆高 on 2024/01/08.
//

import Foundation

func sendRequest(completion: @escaping (Result<String, Error>) -> Void) {
    if var urlComponents = URLComponents(string: "http://localhost:31577/path") {
        urlComponents.queryItems = [
            URLQueryItem(name: "message", value: "Hello Fastify")
        ]

        if let url = urlComponents.url {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // ここでエラーハンドリングとレスポンス処理
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    completion(.success(responseString))
                } else {
                    completion(.failure(NSError()))
                }
            }
            task.resume()
        }
    }
}

