//
//  SPDLocationProviderTests.swift
//  SpeedometerTests
//
//  Created by Vuk Knežević on 7/14/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import Speedometer
import CoreLocation

class SPDLocationProviderTests: XCTestCase {
    
    var sut: SPDLocationProvider!
    
    var locationManagerMock: SPDLocationManagerMock!
    var locationAuthorizationMock: SPDLocationAuthorizationMock!
    var consumerMock: SPDLocationConsumerMock!
    
    override func setUp() {
        super.setUp()
        
        locationManagerMock = SPDLocationManagerMock()
        locationAuthorizationMock = SPDLocationAuthorizationMock()
        consumerMock = SPDLocationConsumerMock()
        
        // mora prava klasa da se uptrebi na sut-u
        sut = SPDDefaultLocationProvider(locationManager: locationManagerMock, locationAuthorization: locationAuthorizationMock)
        sut.add(consumerMock)
    }

    // linija 45
    func test_authorizedNotification_startUpdatingLocation() {
        // Arrange
        // Act
        NotificationCenter.default.post(name: .SPDLocationAuthorized, object: locationAuthorizationMock)
        // Assert
        XCTAssertTrue(locationManagerMock.didStartUpdatingLocation)
    }
    
    // linije 59
    func test_updatedLocations_passesLocationsToConsumer() {
        // Arrange
        let expectedLocation = CLLocation()
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [expectedLocation])
        // Assert
        XCTAssertEqual(expectedLocation, consumerMock.lastLocation)
    }
    
    // linija 68
    func test_updatedLocations_noLocations_nothingIsPassedToConsumers() {
        // Arrange
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [])
        // Assert
        XCTAssertNil(consumerMock.lastLocation)
    }
    
    // linije 68 opet, samo druga varijanta
    func test_updatedLocations_severalLocations_mostRecentLocationIsPassedToConsumers() {
        // Arrange
        let timeStamp = Date()
        let oldLocation = createLocation(with: timeStamp)
        let newLocation = createLocation(with: timeStamp.addingTimeInterval(60))
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [oldLocation, newLocation])
        // Assert
        // proveri da li se poslednja tj nova lookacija prosledjue korisniku
        XCTAssertEqual(newLocation, consumerMock.lastLocation)
    }
    
    // linija 37
    func test_deinit_stopUpdatingLocation() {
        // Arrange
        // Act
        sut = nil
        // Assert
        XCTAssertTrue(locationManagerMock.didStopUpdatingLocation)
    }
    
    func createLocation(with timeStamp: Date) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: timeStamp)
    }
}
