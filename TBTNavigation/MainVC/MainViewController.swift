//
//  MainViewController.swift
//  TBTNavigation
//
//  Created by Ali Reza Alemi on 3/26/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private var cancellableCollection: Array<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.shouldPresentAlertController.sink { [weak self] alertController in
            self?.present(alertController, animated: true)
        }.store(in: &cancellableCollection)
        LocationManager.shared.startUpdatingLocation()
        LocationManager.shared.didUpdateLocation.sink { location in
            print(location.coordinate)
        }.store(in: &cancellableCollection)
    }

}
