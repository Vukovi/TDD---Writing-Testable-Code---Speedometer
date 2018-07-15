//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Vuk Knezevic on 7/11/18.
//  Copyright © 2018 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembler {
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    private let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDlocationSpeedCheckerAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
        
        assembler.apply(assembly: ViewControllerAssembly())
        
        // dodaje se zbog testiranja
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            assembler.apply(assembly: SPDLocationManagerUItestMockAssembly())
        }
    }
}
