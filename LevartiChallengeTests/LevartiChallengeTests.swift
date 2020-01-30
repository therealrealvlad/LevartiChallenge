//
//  LevartiChallengeTests.swift
//  LevartiChallengeTests
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import XCTest
@testable import LevartiChallenge

class LevartiChallengeTests: XCTestCase {
    
    let loginViewController = LoginViewController()
    let loginInteractorSpy = LoginInteractorSpy()

    override func setUp() {
        loginViewController.interactor = loginInteractorSpy
        _ = loginViewController.view
    }

    func test_didTryLogin_whenDidTapLoginWithValidData() {

        // When valid input data provided
        let dummyModel = LevartiChallenge.Data.Login.Model()
        loginViewController.username.text = dummyModel.username
        loginViewController.password.text = dummyModel.password

        // Then login tapped
        loginViewController.didTapLogin(UIButton())
        
        // Expect interactor to try log in
        XCTAssertTrue(loginInteractorSpy.didTryLogin)
    }
    
    func test_didTryLogin_whenDidTapLoginWithoutData() {

        // When invalid input data provided
        loginViewController.username.text = ""
        loginViewController.password.text = ""

        // Then login tapped
        loginViewController.didTapLogin(UIButton())
        
        // Expect interactor to NOT try log in
        XCTAssertFalse(loginInteractorSpy.didTryLogin)
    }

    class LoginInteractorSpy: LoginInteracting {
        
        var didTryLogin: Bool = false

        func login(withViewModel model: View.Login.Model) {
            didTryLogin = true
        }
    }
}
