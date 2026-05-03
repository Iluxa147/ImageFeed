//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 02.05.2026.
//

import Foundation

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    
    private let tokenStorage = OAuth2TokenStorage.shared
    
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let completionHandler: (Result<String, Error>) -> Void = { result in
            assert(Thread.isMainThread)
            switch result {
            case .success(let token):
                print("Auth token get succeed: \(token)")
            case .failure(let error):
                print("Auth token get failed with error: \(error.localizedDescription)")
            }
        }
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            print(NetworkError.invalidRequest.localizedDescription)
            completionHandler(.failure(NetworkError.invalidRequest))
            
            return
        }
        
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let tokenResponse = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    self.tokenStorage.token = tokenResponse.accessToken
                    completionHandler(.success(tokenResponse.accessToken))
                } catch {
                    print(NetworkError.decodingError(error))
                    completionHandler(.failure(NetworkError.decodingError(error)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")
        else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ConstantsApiUnsplash.accessKey),
            URLQueryItem(name: "client_secret", value: ConstantsApiUnsplash.secretKey),
            URLQueryItem(name: "redirect_uri", value: ConstantsApiUnsplash.redirectUri),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
}
