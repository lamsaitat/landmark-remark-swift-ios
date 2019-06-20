//
//  SignupViewControllerTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class SignupViewControllerTests: XCTestCase {
    var vc: SignupViewController!
    
    override func setUp() {
        vc = createViewController()
        vc.loadViewIfNeeded()
    }

    override func tearDown() {
        vc = nil
    }
    
    func testLoadView() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.navigationController)
        XCTAssertNotNil(vc.view)
    }
}


extension SignupViewControllerTests {
    func createViewController() -> SignupViewController {
        guard let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupNavController") as? UINavigationController, let vc = navController.viewControllers.first as? SignupViewController else {
            fatalError("Unable to create SignupNavController from storyboard.")
        }
        return vc
    }
}
