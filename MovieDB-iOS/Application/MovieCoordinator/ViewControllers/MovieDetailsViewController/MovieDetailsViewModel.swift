//
//  MovieDetailsViewModel.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

final class MovieDetailsViewModel {
    let movieItemDTO: MovieItemDTO
    
    init(movieItemDTO: MovieItemDTO) {
        self.movieItemDTO = movieItemDTO
    }
}
