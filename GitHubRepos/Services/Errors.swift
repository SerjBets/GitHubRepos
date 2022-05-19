//
//  Errors.swift
//  GitHubRepos
//  Created by Serhii Bets on 13.04.2022.
//  Copyright by Serhii Bets. All rights reserved.

import Foundation

enum ConnectionErrors: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case noConnection
    case serializationError
    case noImage
    
    var localizedDescription: String {
        switch self {
        case .apiError          : return "Failed to fetch data"
        case .invalidEndpoint   : return "Invalid endpoint"
        case .invalidResponse   : return "Invalid response"
        case .noData            : return "No data"
        case .noConnection      : return "Check the internet connection and press Retry"
        case .serializationError: return "Failed to decode data"
        case .noImage           : return "No Image to download"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
