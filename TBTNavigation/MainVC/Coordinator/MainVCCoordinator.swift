//
//  MainVCCoordinator.swift
//  TBTNavigation
//
//  Created by Ali Reza Alemi on 3/26/24.
//

import UIKit.UINavigationController

class MainVCCoordinator: Coordinator {
    //MARK: - Properties
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    //MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Methods
    
    func start() {
        let viewController = MainViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
