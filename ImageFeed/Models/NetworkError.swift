//
//  NetworkError.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 04.05.2026.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
}
