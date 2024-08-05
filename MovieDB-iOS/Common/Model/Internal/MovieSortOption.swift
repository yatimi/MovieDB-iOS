//
//  MovieSortOption.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

enum MovieSortOption: CaseIterable {
    case popularityDescending
    case popularityAscending
    
    case releaseDateDescending
    case releaseDateAscending
    
    case voteAverageAscending
    case voteAverageDescending
    
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
    
    var localizedName: String {
        switch self {
        case .popularityDescending:
            return "sorting_popularity_descending".localize()
        case .popularityAscending:
            return "sorting_popularity_ascending".localize()
        case .releaseDateDescending:
            return "sorting_release_date_descending".localize()
        case .releaseDateAscending:
            return "sorting_release_date_ascending".localize()
        case .voteAverageAscending:
            return "sorting_vote_average_ascending".localize()
        case .voteAverageDescending:
            return "sorting_vote_average_descending".localize()
        }
    }
    
}

