//
//  SPDLocationAuthorizationDelegateMock.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationDelegateMock: SPDLocationAuthorizationDelegate {
    
    var authorizationWasDenied = false
    
    func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
        authorizationWasDenied = true
    }
    
    
}

