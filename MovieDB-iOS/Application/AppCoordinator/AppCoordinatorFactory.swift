//
//  AppCoordinatorFactory.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

class AppCoordinatorFactory {
    
    func makeMovieCoordinatorBox(router: Router) -> MovieCoordinator {
        return MovieCoordinator(router: router)
    }
    
}
