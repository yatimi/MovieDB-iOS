//
//  MoviesNetworkError.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

enum MoviesNetworkError: LocalizedError, Equatable {
    static func == (lhs: MoviesNetworkError, rhs: MoviesNetworkError) -> Bool {
        lhs.errorDescription == rhs.localizedDescription
    }
    
    case couldNotDecode
    case pageIsNotAvailable
    case invalidStatusCode(Int)
    case unexpectedError(Error)
    case networkUnavailable
    
    var errorDescription: String? {
        switch self {
        case .couldNotDecode:
            return Messages.cannotDecodeResponse
        case .pageIsNotAvailable:
            return Messages.pageIsNotAvailable
        case let .invalidStatusCode(code):
            return Messages.invalidStatusCode(with: code)
        case let .unexpectedError(error):
            return Messages.unexpectedError(with: error)
        case .networkUnavailable:
            return Messages.networkUnavailable
        }
    }
    
}
