//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 02.05.2026.
//

import Foundation

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private init() {}
    
    private enum Constants {
        static let tokenKey = "OAuth2Token"
        static let storage: UserDefaults = .standard
    }
    
    var token: String? {
        get { Constants.storage.string(forKey: Constants.tokenKey) }
        set { Constants.storage.set(newValue, forKey: Constants.tokenKey) }
    }
}
