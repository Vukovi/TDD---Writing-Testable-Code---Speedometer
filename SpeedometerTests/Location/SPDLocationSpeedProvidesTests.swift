//
//  SPDLocationSpeedProvidesTests.swift
//  SpeedometerTests
//
//  Created by Vuk Knežević on 7/14/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedProvidesTests: XCTestCase {
    
    var sut: SPDLocationSpeedProvider!
    
    var locationProviderMock: SPDLocationProviderMock!
    var delegateMock: SPDLocationSpeedProviderDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        locationProviderMock = SPDLocationProviderMock()
        delegateMock = SPDLocationSpeedProviderDelegateMock()
        
        sut = SPDDefaultLocationSpeedProvider(locationProvider: locationProviderMock)
        sut.delegate = delegateMock
    }
    
    func test_consumeLocation_speedLessThenZero_provideZeroToDelegate() {
        // Arrange
        let location = createLocaion(with: -10)
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        // Assert
        // treba da brzina koja je prosledjena delegatu bude 0, koristili smo negativnu
        XCTAssertEqual(0, delegateMock.lastSpeed)
    }
    
    func test_consumeLocation_speedGratherThenZero_provideSpeedToDelegate() {
        // Arrange
        let location = createLocaion(with: 10)
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        // Assert
        // treba da brzina koja je prosledjena delegatu bude 10, koju smo i koristili
        XCTAssertEqual(10, delegateMock.lastSpeed)
    }
    
    func createLocaion(with speed: CLLocationSpeed) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: speed, timestamp: Date())
    }
    
}
