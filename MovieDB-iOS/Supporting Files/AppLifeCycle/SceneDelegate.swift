//
//  SceneDelegate.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window!.makeKeyAndVisible()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window

        appCoordinator = AppCoordinator(
            window: window!,
            coordinatorFactory: AppCoordinatorFactory()
        )
        appCoordinator.start(deepLinkOption: nil)
    }
    
}
