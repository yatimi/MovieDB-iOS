//
//  MovieListViewModel.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

final class MovieListViewModel: SearchableTableViewModel {
    
    // MARK: - Properties
    
    var numberOfEntities: Int {
        dataSource.count
    }
    
    var query: String = ""
    var sortOption: MovieSortOption = .popularityDescending
    
    private(set) var dataSource: [String] = Array(repeating: "Mock Item", count: 20)
    
    // MARK: - Public methods
    
    func sortMovies(by option: MovieSortOption) {
        sortOption = option
        /// Load a new list applying a new sorting order
    }
    
    func search(_ query: String, forceRefresh: Bool) {
        print(#function, "query: \(query), \(forceRefresh)")
    }
}
