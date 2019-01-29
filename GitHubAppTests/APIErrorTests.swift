//
//  APIErrorTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class APIErrorTests: XCTestCase {

    func testDecodeAPIError() throws {
        let json = """
{"message":"Problems parsing JSON"}
"""
        let error = try JSONDecoder().decode(APIError.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(error.message, "Problems parsing JSON")
    }
}
