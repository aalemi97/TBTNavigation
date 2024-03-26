//
//  SceneDelegate.swift
//  TBTNavigation
//
//  Created by Ali Reza Alemi on 3/26/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    //MARK: - Properties
    
    var window: UIWindow?
    var coordinator: Coordinator?

    //MARK: - Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        startApplication(scene)
    }
    
    private func startApplication(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        coordinator = MainVCCoordinator(navigationController: navigationController)
        coordinator?.start()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
    }

}
