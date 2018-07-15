//
//  SPDLocationConsumerMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationConsumerMock: SPDLocationConsumer {
    
    var lastLocation: CLLocation?
    
    func consumeLocation(_ location: CLLocation) {
        lastLocation = location
    }
    
    
}
