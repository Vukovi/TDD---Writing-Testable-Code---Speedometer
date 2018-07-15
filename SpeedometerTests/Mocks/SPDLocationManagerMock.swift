//
//  SPDLocationManagerMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationManagerMock: SPDLocationManager {
    
    var requestedWhenInUseAuthorization = false
    var didStartUpdatingLocation = false
    var didStopUpdatingLocation = false
    
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    func requestWhenInUseAuthorization() {
        requestedWhenInUseAuthorization = true
    }
    
    func startUpdatingLocation() {
        didStartUpdatingLocation = true
    }
    
    func stopUpdatingLocation() {
        didStopUpdatingLocation = true
    }
}
