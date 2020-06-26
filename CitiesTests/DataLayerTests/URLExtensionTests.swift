//
//  URLExtensionTests.swift
//  CitiesTests
//
//  Created by Mina Mikhael on 26.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import XCTest
@testable import Cities

class URLExtensionTests: XCTestCase {

    func testInit() {
        let mockService = MockFileService()
        let url = URL(service: mockService)
        XCTAssertEqual(url.lastPathComponent, "\(mockService.filePath).\(mockService.fileType)")
    }
}

final class MockFileService: FileLoadService {

    var filePath: String {
        return "cities"
    }

    var fileType: String {
        return "json"
    }
}
