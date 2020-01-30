//
//  AppDelegate.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The app coordinator
    let appCoordinator = AppCoordinator()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // The window frame isset by the bounds of the user-interface main sceen
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set the window root controller to the app coordinator root
        window.rootViewController = appCoordinator.rootViewController
        
        // Configure the window and app coordinator
        window.makeKeyAndVisible()
        
        // Set the window
        self.window = window
        
        // Start the app coordinator display
        appCoordinator.start()
        return true
    }
}

