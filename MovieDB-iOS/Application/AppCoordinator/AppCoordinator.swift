//
//  AppCoordinator.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {

    // MARK: - Private properties

    private let window: UIWindow
    private let coordinatorFactory: AppCoordinatorFactory

    // MARK: - Lifecycle

    init(window: UIWindow, coordinatorFactory: AppCoordinatorFactory) {
        self.window = window
        self.coordinatorFactory = coordinatorFactory
    }

    override func start(deepLinkOption: DeepLinkOption?) {
        let startController = runMovieFlow()
        self.window.rootViewController = startController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Private methods
    
    @discardableResult
    private func runMovieFlow() -> UIViewController {
        let rootController = UINavigationController()
        let router = Router(rootController: rootController)
        let coordinator = coordinatorFactory.makeMovieCoordinatorBox(router: router)
        
        addDependency(coordinator)
        coordinator.start(deepLinkOption: nil)

        return rootController
    }
}
