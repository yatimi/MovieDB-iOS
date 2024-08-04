//
//  MovieSortOption.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

enum MovieSortOption: String, CaseIterable {
    case popularityDescending = "Popularity Descending"
    case popularityAscending = "Popularity Ascending"
    
    case releaseDateDescending = "Release Date Descending"
    case releaseDateAscending = "Release Date Ascending"
    
    case voteAverageAscending = "Vote Average Ascending"
    case voteAverageDescending = "Vote Average Descending"
}
