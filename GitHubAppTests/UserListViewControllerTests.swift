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
        vc?.gitHubAPI = api
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 1)
        XCTAssertEqual(number, 1)
        
        let cell = vc?.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! UserListCell
        XCTAssertEqual(cell.userNameLabel.text, "name")
    }
    
    func testUserIsError(completion: @escaping (([User]?, Error?) -> Void)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let error = """
{"message":"Problems parsing JSON"}
"""
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        api.userResult = ([], error as? Error)
        
        vc?.loadViewIfNeeded()
        
        XCTAssertTrue(vc?.presentedViewController is UIAlertController)
        //errorが帰ってきたら、アラートが表示されるかどうかを確認したい。
    }
    
    //cellの表示に関するテスト
    func testSelectedCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc?.tableView)
        
        vc?.loadViewIfNeeded()
        
//        let indexpath = IndexPath(row: 0, section: 1)
//        vc?.tableView.selectRow(at: indexpath, animated: false, scrollPosition: .none)
//        XCTAssertEqual(vc?.selectedUserName, "name")
    }
}
