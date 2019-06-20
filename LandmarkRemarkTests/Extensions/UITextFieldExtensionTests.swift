//
//  UITextFieldExtensionTests.swift
//  LandmarkRemarkTests
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import LandmarkRemark

class UITextFieldExtensionTests: BaseTestCase {

    func testMarkAsInvalid() {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        tf.markAsInvalid()
        
        XCTAssertEqual(tf.layer.borderWidth, 1.0)
        XCTAssertEqual(tf.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(tf.layer.cornerRadius, 5.0)
    }
    
    func testMarkAsValid() {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        tf.markAsValid()
        
        XCTAssertEqual(tf.layer.borderWidth, 0)
        XCTAssertEqual(tf.layer.cornerRadius, 0)
        XCTAssertEqual(tf.layer.borderColor, UIColor.clear.cgColor)
    }

}
