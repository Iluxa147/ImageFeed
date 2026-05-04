//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 02.05.2026.
//

import Foundation

struct OAuthTokenResponseBody: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
