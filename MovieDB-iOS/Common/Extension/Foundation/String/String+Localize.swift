//
//  String+Localize.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import Foundation

extension String {
    
    func localize(comment: String = "", arguments: CVarArg...) -> String {
        let defaultLanguage = "en"
        let value = String(format: NSLocalizedString(self, comment: comment), arguments: arguments)
        
        if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
            return value
        }
        
        guard
            let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
            return value
        }
        
        return String(
            format: NSLocalizedString(self, bundle: bundle, comment: comment),
            arguments: arguments
        )
    }
    
}

