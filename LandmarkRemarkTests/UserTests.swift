//
//  UserTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 19/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class UserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserInstantiation() {
        let uid = "590fc88a-80ac-40b2-be05-77d4479cb3f4"
        let email = "testuser@example.com"
        let username = "Testuser001"
        
        let user = User(uid: uid, email: email, username: username)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user.uid, uid)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.email, email)
    }

}
