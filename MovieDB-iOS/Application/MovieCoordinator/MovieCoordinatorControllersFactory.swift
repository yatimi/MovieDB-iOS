//
//  MovieCoordinatorControllersFactory.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

final class MovieCoordinatorControllersFactory {
    
    func makeMovieListViewController() -> MovieListViewController {
        let viewModel = MovieListViewModel()
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeMovieDetailsViewController(movieItemDTO: MovieItemDTO) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(movieItemDTO: movieItemDTO)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeFullPhotoViewController(image: UIImage) -> FullPhotoViewController {
        let viewModel = FullPhotoViewModel(image: image)
        let viewController = FullPhotoViewController(viewModel: viewModel)
        return viewController
    }
    
}
