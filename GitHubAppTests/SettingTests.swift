//
//  SettingTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class SettingTests: XCTestCase {
    
    func testSettingToken() {
        let setting = Setting(defaults: UserDefaults.standard)
        setting.token = "test"
        XCTAssertEqual(setting.token, "test")
    }
    
    func testSettingTokenForTestonly() {
        let setting = Setting(defaults: UserDefaults(suiteName: "TestOnly")!)
        XCTAssertEqual(setting.token, "")
    }    
}
