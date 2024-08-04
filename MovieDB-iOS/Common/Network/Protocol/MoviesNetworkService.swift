//
//  MoviesNetworkService.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Alamofire

protocol MoviesNetworkService {
    
    @discardableResult
    func getMovies(
        with pagination: PaginationModel,
        by sortOption: MovieSortOption,
        completionHandler: @escaping ((Result<MovieListResponse, MoviesNetworkError>) -> Void)
    ) -> DataRequest?
    
    @discardableResult
    func searchMovies(
        with pagination: PaginationModel,
        searchQuery: String,
        completionHandler: @escaping ((Result<MovieListResponse, MoviesNetworkError>) -> Void)
    ) -> DataRequest?
    
}
