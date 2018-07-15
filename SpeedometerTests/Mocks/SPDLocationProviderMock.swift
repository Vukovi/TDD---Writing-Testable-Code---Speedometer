//
//  SPDLocationProviderMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationProviderMock: SPDLocationProvider {
    
    var lastConsumer: SPDLocationConsumer?

    func add(_ consumer: SPDLocationConsumer) {
        lastConsumer = consumer
    }
    
}
