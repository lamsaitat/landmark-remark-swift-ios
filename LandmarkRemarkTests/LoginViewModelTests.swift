//
//  LoginViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark
@testable import Firebase

class LoginViewModelTests: XCTestCase {
    var vm: LoginViewModel!
    override func setUp() {
        vm = LoginViewModel()
    }

    override func tearDown() {
        vm = nil
    }
    
    func testPerformLogin() {
        let expectation = XCTestExpectation(description: "Waiting for login to return.")
        let email = "testuser1@example.com"
        let password = "Th1s1sAWeakPassw0rd"
        var resultingUser: Firebase.User!
        vm.performLogin(withEmail: email, password: password) { user, error in
            XCTAssertNil(error)
            XCTAssertNotNil(user)
            resultingUser = user
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(resultingUser.uid)
        XCTAssertNotNil(resultingUser.email)
    }
}
