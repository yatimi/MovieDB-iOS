//
//  SearchableTableViewModel.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

protocol SearchableTableViewModel {
    
    // MARK: - Properties
    
    var sortOption: MovieSortOption { get set }
    
    var numberOfEntities: Int { get }
    
    var query: String { get set }
    
    // MARK: - Methods
    
    func search(_ query: String, forceRefresh: Bool)
}
