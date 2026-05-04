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
    
    private enum ConstantsInner {
        static let tokenKey = "OAuth2Token"
        static let storage: UserDefaults = .standard
    }
    
    var token: String? {
        get { ConstantsInner.storage.string(forKey: ConstantsInner.tokenKey) }
        set { ConstantsInner.storage.set(newValue, forKey: ConstantsInner.tokenKey) }
    }
}
