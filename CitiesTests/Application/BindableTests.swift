//
//  BindableTests.swift
//  CitiesTests
//
//  Created by Mina Mikhael on 26.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import XCTest
@testable import Cities

class BindableTests: XCTestCase {

    func testBind() {
        let bindable = Bindable(false)
        let expectListenerCalled = expectation(description: "Listener is called")
        bindable.bind { value in
            XCTAssert(value == true, "testBind failed, should have been true")
            expectListenerCalled.fulfill()
        }
        bindable.value = true
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testBindAndFire() {
        let bindable = Bindable(true)
        let expectListenerCalled = expectation(description: "Listener is called")
        bindable.bindAndFire { value in
            XCTAssert(value == true, "testBindAndFire failed, should have been true")
            expectListenerCalled.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
