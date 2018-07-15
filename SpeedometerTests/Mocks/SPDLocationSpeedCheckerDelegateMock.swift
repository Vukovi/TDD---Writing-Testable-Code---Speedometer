//
//  SPDLocationSpeedCheckerDelegateMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationSpeedCheckerDelegateMock: SPDLocationSpeedCheckerDelegate {
    
    var didChangeExceedingSpeed = false
    
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        didChangeExceedingSpeed = true
    }
    
    
}
