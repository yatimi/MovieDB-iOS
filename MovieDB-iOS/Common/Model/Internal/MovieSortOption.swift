//
//  MovieSortOption.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

enum MovieSortOption: String, CaseIterable {
    #warning("Localize")
    case popularityDescending = "Popularity Descending"
    case popularityAscending = "Popularity Ascending"
    
    case releaseDateDescending = "Release Date Descending"
    case releaseDateAscending = "Release Date Ascending"
    
    case voteAverageAscending = "Vote Average Ascending"
    case voteAverageDescending = "Vote Average Descending"
    
    var serverValue: String {
        switch self {
        case .popularityDescending:
            return "popularity.desc"
        case .popularityAscending:
            return "popularity.asc"
        case .releaseDateDescending:
            return "primary_release_date.desc"
        case .releaseDateAscending:
            return "primary_release_date.asc"
        case .voteAverageAscending:
            return "vote_average.asc"
        case .voteAverageDescending:
            return "vote_average.desc"
        }
    }
}
