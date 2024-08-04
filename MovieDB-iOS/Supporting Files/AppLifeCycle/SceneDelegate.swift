//
//  SceneDelegate.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        start(with: windowScene)
    }
    
}

private extension SceneDelegate {
    func start(with windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let viewModel = MovieListViewModel()
        let viewController = MovieListViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = rootViewController
    }
}
