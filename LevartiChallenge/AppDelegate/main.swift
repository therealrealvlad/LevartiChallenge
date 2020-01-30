//
//  main.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

// The main application is initialized with a nil app delegate during unit tests in order to keep the tests isolated from the normal app functionality
UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil)
