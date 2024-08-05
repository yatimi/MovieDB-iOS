//
//  Messages.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

struct Messages {
    
    // MARK: - Networking
    
    static let cannotDecodeResponse = "error_cannot_decode_response".localize()
    static let pageIsNotAvailable = "error_page_not_available".localize()
    static let networkUnavailable = "error_network_unavailable".localize()
    
    static func invalidStatusCode(with code: Int) -> String {
        return String(format: "error_invalid_status_code".localize(), code)
    }
    
    static func unexpectedError(with error: Error) -> String {
        return error.localizedDescription
    }
    
}
