//
//  SPDLocationAuthorizationMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationMock: SPDLocationAuthorization {
    weak var delegate: SPDLocationAuthorizationDelegate?
    
    var didCheckAuthorization = false
    
    func checkAuthorization() {
        didCheckAuthorization = true
    }
    
    
}
