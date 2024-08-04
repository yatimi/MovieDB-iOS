//
//  AppConstants.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

struct AppConstants {
    
    struct MovieDB {
        static let apiKey: String = "039fe8d5f2d6fbb1ef9743da00b0c148"
        static let readAccessToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMzlmZThkNWYyZDZmYmIxZWY5NzQzZGEwMGIwYzE0OCIsIm5iZiI6MTcyMjQ0OTUzMi43NTc2NjYsInN1YiI6IjY2YWE3ZDg2YTIxYTNhODBkNTBhZjkyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UOV9gOkemNLJT0jexFX8OlmPa0zcNZl5vGtSamUBcu8"
        
        static let baseURLString: String = "https://api.themoviedb.org/3"
        
        static let mediumImageSizePath: String = "https://image.tmdb.org/t/p/w500"
        static let originalImageSizePath: String = "https://image.tmdb.org/t/p/original"
    }
    
    struct Language {
        static let currentLocalizeSymbol: String = String(Locale.preferredLanguages[0].prefix(2))
    }
    
}
