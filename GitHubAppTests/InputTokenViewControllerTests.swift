//
//  InputTokenViewControllerTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class InputTokenViewControllerTests: XCTestCase {
    
    /// 最初の起動時にTextFieldが空かどうかのテスト
    func testFirstTextField() {
        let s = UIStoryboard(name: "Main", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: "InputTokenViewController") as? InputTokenViewController
        XCTAssertNotNil(vc)
        
        let setting = Setting(defaults: UserDefaults.standard)
        setting.token = ""
        
        vc?.loadViewIfNeeded()
        XCTAssertEqual(vc?.personalAccessToken.text, "")
    }
    
    /// 保存されたトークンがTextFieldに表示されるかどうかのテスト
    func testStoredTextField() {
        let s = UIStoryboard(name: "Main", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: "InputTokenViewController") as? InputTokenViewController
        XCTAssertNotNil(vc)
        
        let setting = Setting(defaults: UserDefaults.standard)
        setting.token = "test"
        
        vc?.loadViewIfNeeded()
        XCTAssertEqual(vc?.personalAccessToken.text, "test")
    }
    
    /// enterボタンが押された時、入力したトークンが保存されているかのテスト
    func testEnterButtonForStoring() {
        let s = UIStoryboard(name: "Main", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: "InputTokenViewController") as? InputTokenViewController
        XCTAssertNotNil(vc)
        
        vc?.loadViewIfNeeded()
        vc?.personalAccessToken.text = "abc"
        vc?.enterButton.sendActions(for: .touchUpInside)
        
        let setting = Setting(defaults: UserDefaults.standard)
        XCTAssertEqual(setting.token, "abc")
    }
    
}
