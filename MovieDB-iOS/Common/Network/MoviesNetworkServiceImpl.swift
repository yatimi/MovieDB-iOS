//
//  MoviesNetworkServiceImpl.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Alamofire

final class MoviesNetworkServiceImpl: MoviesNetworkService {
    private let networkService: NetworkServiceExecutable
    
    init(networkService: NetworkServiceExecutable = NetworkService()) {
        self.networkService = networkService
    }
    
    func getMovies(
        with pagination: PaginationModel,
        by sortOption: MovieSortOption,
        completionHandler: @escaping ((Result<MovieListResponse, MoviesNetworkError>) -> Void)
    ) -> DataRequest? {
        let target = MoviesTarget.getMovieList(pagination: pagination, sortOption: sortOption)
        return networkService.execute(target: target, completionHandler: completionHandler)
    }
    
    func searchMovies(
        with pagination: PaginationModel,
        searchQuery: String,
        completionHandler: @escaping ((Result<MovieListResponse, MoviesNetworkError>) -> Void)
    ) -> DataRequest? {
        let target = MoviesTarget.searchMovies(pagination: pagination, searchQuery: searchQuery)
        return networkService.execute(target: target, completionHandler: completionHandler)
    }
    
}
