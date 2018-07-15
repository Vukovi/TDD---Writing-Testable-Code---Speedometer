//
//  SPDLocationSpeedProviderDelegateMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedProviderDelegateMock: SPDLocationSpeedProviderDelegate {
    func didUpdate(speed: CLLocationSpeed) {
        lastSpeed = speed
    }
    
    var lastSpeed: CLLocationSpeed?
}
