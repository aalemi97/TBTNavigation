//
//  Coordinator.swift
//  TBTNavigation
//
//  Created by Ali Reza Alemi on 3/26/24.
//

import UIKit.UINavigationController

protocol Coordinator {
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    // MARK: - Methods
    
    func start()
}
