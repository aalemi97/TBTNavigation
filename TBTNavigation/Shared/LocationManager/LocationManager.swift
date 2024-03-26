//
//  LocationManager.swift
//  TBTNavigation
//
//  Created by Ali Reza Alemi on 3/26/24.
//

import UIKit
import CoreLocation
import Combine


class LocationManager: NSObject, CLLocationManagerDelegate {
    //MARK: - Shared Object
    
    static let shared: LocationManager = LocationManager()
    
    //MARK: - Properties
    
    private let manger: CLLocationManager
    
    private var isStarted: Bool
    
    let shouldPresentAlertController: PassthroughSubject<UIAlertController, Never>
    
    let didUpdateLocation: PassthroughSubject<CLLocation, Never>
    
    let didUpdateHeading: PassthroughSubject<CLHeading, Never>
    
    //MARK: - Initializers
    
    private override init() {
        self.manger = CLLocationManager()
        self.isStarted = false
        self.shouldPresentAlertController = PassthroughSubject()
        self.didUpdateLocation = PassthroughSubject()
        self.didUpdateHeading = PassthroughSubject()
        super.init()
        manger.delegate = self
        checkAuthorizationStatus()
    }
    
    //MARK: - Methods
    
    func startUpdatingLocation() {
        guard !isStarted else { return }
        guard (manger.authorizationStatus == .authorizedAlways) || (manger.authorizationStatus == .authorizedWhenInUse) else { return }
        isStarted = true
        manger.desiredAccuracy = kCLLocationAccuracyBest
        manger.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        guard isStarted else { return }
        isStarted = false
        manger.desiredAccuracy = kCLLocationAccuracyReduced
        manger.stopUpdatingLocation()
    }
    
    private func checkAuthorizationStatus() {
        switch manger.authorizationStatus {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        default:
            manger.requestWhenInUseAuthorization()
        }
    }
    
    private func requestAlwaysAuthorization() {
        let alertController = UIAlertController(title: "Allow '\(Bundle.main.infoDictionary?["CFBundleName"] ?? "App")' to also use your location even when you are not using the app?", message: " '\(Bundle.main.infoDictionary?["CFBundleName"] ?? "App")' needs access to your location.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Keep Only While Using", style: .default)
        let defaultAction = UIAlertAction(title: "Change to Always Allow", style: .default) { action in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        shouldPresentAlertController.send(alertController)
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus != .authorizedAlways else { return }
        requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        didUpdateLocation.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        didUpdateHeading.send(newHeading)
    }
    
}
