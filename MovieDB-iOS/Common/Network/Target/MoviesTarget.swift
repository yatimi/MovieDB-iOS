//
//  MoviesTarget.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation
import Alamofire

enum MoviesTarget {
    case getMovieList(pagination: PaginationModel, sortOption: MovieSortOption)
    case searchMovies(pagination: PaginationModel, searchQuery: String)
}

extension MoviesTarget: API {
    
    var baseURL: String {
        return AppConstants.MovieDB.baseURLString
    }
    
    var path: String {
        switch self {
        case .getMovieList:
            return "/discover/movie"
        case .searchMovies:
            return "/search/movie"
        }
    }
    
    var URLConvertible: String {
        return baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieList, .searchMovies:
            return .get
        }
    }
    
    var parameters: Parameters? {
        var parameters: [String: Any]?
        
        switch self {
        case let .getMovieList(pagination, sortOption):
            parameters = ["page": pagination.page, "sort_by": sortOption.serverValue]
        case let .searchMovies(pagination, searchQuery):
            parameters = ["page": pagination.page, "query": searchQuery]
        }
        
        parameters?["language"] = AppConstants.Language.currentLocalizeSymbol
        
        return parameters
    }
    
    var headers: HTTPHeaders? {
        let dict = [
            "accept": "application/json",
            "Authorization": "Bearer \(AppConstants.MovieDB.readAccessToken)"
        ]
        return HTTPHeaders(dict)
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
