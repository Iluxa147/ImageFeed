//
//  UrlSession+Data.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 02.05.2026.
//

import Foundation

extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        let task = dataTask(with: request) { data, response, error in
            func complete(_ result: Result<Data, Error>) {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error {
                complete(.failure(NetworkError.urlRequestError(error)))
                return
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                complete(.failure(NetworkError.urlSessionError))
                return
            }
            
            guard 200..<300 ~= httpUrlResponse.statusCode else {
                complete(.failure(NetworkError.httpStatusCode(httpUrlResponse.statusCode)))
                return
            }
            
            guard let data else {
                complete(.failure(NetworkError.urlSessionError))
                return
            }
            
            complete(.success(data))
        }
        
        return task
    }
}
