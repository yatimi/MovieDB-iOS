//
//  Messages.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation


struct Messages {
    
    #warning("Localize")
    static let cannotDecodeResponse = "Cannot decode response."
    static let pageIsNotAvailable = "Requested page is not available.\n\nTry refreshing the page."
    static let networkUnavailable = "You are offline. Please, enable your Wi-Fi or connect using cellalar data."
    
    static func invalidStatusCode(with code: Int) -> String {
        return "Invalid status code: \(code)."
    }
    
    static func unexpectedError(with error: Error) -> String {
        return error.localizedDescription
    }
    
}
