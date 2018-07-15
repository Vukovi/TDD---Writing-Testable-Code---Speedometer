//
//  SPDLocationManagerUItestMock.swift
//  Speedometer
//
//  Created by Vuk Knežević on 7/15/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import UIKit
import CoreLocation
import Swinject

class SPDLocationManagerUItestMock {
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined {
        didSet {
            authorizationDelegate?.locationManager(self, didChangeAuthorization: authorizationStatus)
        }
    }
}

extension SPDLocationManagerUItestMock: SPDLocationManager {
    
    func requestWhenInUseAuthorization() {
        
        guard let viewController = UIApplication.shared.delegate?.window??.rootViewController else { return }
        
        let alertController = UIAlertController(title: "Location Authorization", message: nil, preferredStyle: .alert)
        let allowAction = UIAlertAction(title: "Allow", style: .default) { [weak self] (_) in
            self?.authorizationStatus = .authorizedWhenInUse
        }
        alertController.addAction(allowAction)
        let dontAllowAction = UIAlertAction(title: "Don't Allow", style: .default) { [weak self] (_) in
            self?.authorizationStatus = .denied
        }
        alertController.addAction(dontAllowAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func startUpdatingLocation() {
        delayPostingLocation()
    }
    
    func stopUpdatingLocation() {
        // Do Nothing
    }
    
    
}

private extension SPDLocationManagerUItestMock {
    func delayPostingLocation() {
        let coordinate = CLLocationCoordinate2D()
        let location = CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 20, timestamp: Date()) // 20 je dato kao neki primer brzine
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.locationManager(strongSelf, didUpdateLocations: [location])
        }
    }
}


class SPDLocationManagerUItestMockAssembly: Assembly {
    // s obzirom da se locationManager registruje za novu klasu, pregazice prethodnu registraciju
    func assemble(container: Container) {
        container.register(SPDLocationManager.self) { (resolver) in
            return SPDLocationManagerUItestMock()
        }
    }
}
