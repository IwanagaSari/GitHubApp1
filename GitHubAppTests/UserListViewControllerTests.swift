//
//  UserListViewControllerTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class DummyGitHubAPI: GitHubAPIType {
    
    var userResult: ([User]?, Error?)
    
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        completion(userResult.0, userResult.1)
    }
}

class UserListViewControllerTests: XCTestCase {
    
    func testUserIsEmpty(completion: @escaping (([User]?, Error?) -> Void)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        
        api.userResult = ([], nil)
        
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 0)
        
    }
    
    func testUserIsOne(completion: @escaping (([User]?, Error?) -> Void)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 1)
        XCTAssertEqual(number, 1)
        
        let cell = vc?.tableView.visibleCells[0] as! UserListCell
        XCTAssertEqual(cell.userNameLabel.text, "name")
        //1行目のセルに表示される名前が一致しているか確認したい。１行目を指定する方法がよくわからず、visibleCellsって
        //ものを使ってみたけど、visiblecellって...?
        
    }
}
