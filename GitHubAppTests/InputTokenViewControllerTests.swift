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
    
    var  vc: InputTokenViewController!
    
    override func setUp() {
        super.setUp()
        
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputTokenViewController") as? InputTokenViewController
        XCTAssertNotNil(vc)
    }
    
    /// 最初の起動時にTextFieldが空かどうかのテスト
    func testFirstTextField() {
        let setting = Setting(defaults: UserDefaults.standard)
        setting.token = ""
        
        vc?.loadViewIfNeeded()
        XCTAssertEqual(vc?.accessTokenTextField.text, "")
    }
    
    /// 保存されたトークンがTextFieldに表示されるかどうかのテスト
    func testStoredTextField() {
        let setting = Setting(defaults: UserDefaults.standard)
        setting.token = "test"
        
        vc?.loadViewIfNeeded()
        XCTAssertEqual(vc?.accessTokenTextField.text, "test")
    }
    
    /// enterボタンが押された時、入力したトークンが保存されているかのテスト
    func testEnterButtonForStoring() {
        vc?.loadViewIfNeeded()
        vc?.accessTokenTextField.text = "abc"
        vc?.enterButton.sendActions(for: .touchUpInside)
        
        let setting = Setting(defaults: UserDefaults.standard)
        XCTAssertEqual(setting.token, "abc")
    }
}
