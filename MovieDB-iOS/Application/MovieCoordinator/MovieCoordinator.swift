//
//  MovieCoordinator.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

class MovieCoordinator: BaseCoordinator {
    
    // MARK: - Private properties

    private let router: Router
    private let controllersFactory: MovieCoordinatorControllersFactory = .init()

    // MARK: - Lifecycle

    init(router: Router) {
        self.router = router
    }

    // MARK: - Override methods

    override func start(deepLinkOption: DeepLinkOption?) {
        showMovieListViewController()
    }

    // MARK: - Private methods

    private func showMovieListViewController() {
        let controller = controllersFactory.makeMovieListViewController()
        
        controller.onOpenDetails = { [weak self] movieItemDTO in
            guard let self = self else { return }
            self.showMovieDetailsViewController(movieItemDTO: movieItemDTO)
        }
        
        router.setRootController(controller)
    }
    
    private func showMovieDetailsViewController(movieItemDTO: MovieItemDTO) {
        let controller = controllersFactory.makeMovieDetailsViewController(movieItemDTO: movieItemDTO)
        
        controller.onOpenFullPhoto = { [weak self] image in
            guard let self = self else { return }
            self.showFullImageViewController(with: image)
        }
        
        router.push(controller)
    }
    
    private func showFullImageViewController(with image: UIImage) {
        let controller = controllersFactory.makeFullPhotoViewController(image: image)
        
        router.present(controller)
    }
}
