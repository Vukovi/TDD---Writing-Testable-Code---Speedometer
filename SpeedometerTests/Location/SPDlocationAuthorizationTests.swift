//
//  SPDlocationAuthorizationTests.swift
//  SpeedometerTests
//
//  Created by Vuk Knezevic on 7/12/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import Speedometer

class SPDlocationAuthorizationTests: XCTestCase {
    
    // bice unwrapovana zato sto ce u setUp() svaki put biti pozivana
    var sut: SPDLocationAuthorization!
    
    var locationManagerMock: SPDLocationManagerMock!
    var delegateMock: SPDLocationAuthorizationDelegateMock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationManagerMock = SPDLocationManagerMock()
        delegateMock = SPDLocationAuthorizationDelegateMock()
        
        // mora prava klasa da se uptrebi na sut-u
        sut = SPDDefaultLocationAuthorization(locationManager: locationManagerMock)
        sut.delegate = delegateMock
    }
    
    func test_checkAuthorization_notDetermined_requestsAuthorization() {
        // Arrange
        locationManagerMock.authorizationStatus = .notDetermined
        // Act
        sut.checkAuthorization()
        // Assert
        XCTAssertTrue(locationManagerMock.requestedWhenInUseAuthorization)
    }
    
    func test_checkAuthorization_determined_doesNotRequestsAuthorization() {
        // Arrange
        locationManagerMock.authorizationStatus = .denied
        // Act
        sut.checkAuthorization()
        // Assert
        XCTAssertFalse(locationManagerMock.requestedWhenInUseAuthorization)
    }
    
    func test_didChangeAuthorizationStatus_authorizedWhenInUse_notificationIsPosted() {
        // Arrange
        let notificationName = NSNotification.Name.SPDLocationAuthorized.rawValue
        let _ = expectation(forNotification: notificationName, object: sut, handler: nil)
        // Act
        locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .authorizedWhenInUse)
        sut.checkAuthorization()
        // Assert
        waitForExpectations(timeout: 0, handler: nil) // cekaj neku sinhronu aktivnost
    }
    
    func test_didChangeAuthorizationStatus_aauthorizedAlways_notificationIsPosted() {
        // Arrange
        let notificationName = NSNotification.Name.SPDLocationAuthorized.rawValue
        let _ = expectation(forNotification: notificationName, object: sut, handler: nil)
        // Act
        locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .authorizedAlways)
        sut.checkAuthorization()
        // Assert
        waitForExpectations(timeout: 0, handler: nil) // cekaj neku sinhronu aktivnost
    }
    
    func test_didChangeAuthorizationStatus_denied_delegateInformed() {
        // Arrange
        // Act
        locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .denied)
        sut.checkAuthorization()
        // Assert
        XCTAssertTrue(delegateMock.authorizationWasDenied)
    }
    
    func test_didChangeAuthorizationStatus_restricted_delegateInformed() {
        // Arrange
        // Act
        locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .restricted)
        sut.checkAuthorization()
        // Assert
        XCTAssertTrue(delegateMock.authorizationWasDenied)
    }
    
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
}
