//
//  Thread+RunOnMain.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import Foundation

extension Thread {
    
    /// Typealias for a completion block
    typealias Block = () -> ()
    
    /// Runs the specified block on the main thread
    /// - Parameter block: The completion block to run
    static func runOnMain(block: @escaping Block) {
        if isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
