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
        //DispatchQueue.main.async {
            completion(self.userResult.0, self.userResult.1)
        //}
    }

}

class UserListViewControllerTests: XCTestCase {
    
    func testUserIsEmpty() {
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
    
    func testUserIsOne() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserListCell
        XCTAssertEqual(cell.userNameLabel.text, "name")
    }
    
    func testUserIsError() {
        let window = UIWindow()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        api.userResult = (nil, APIError(message: "test"))
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
//        let expect = expectation(description: #function)
//
//        DispatchQueue.main.async {
//            expect.fulfill()
//        }
//
//        wait(for: [expect], timeout: 1)
//
//        XCTAssertTrue(vc?.presentedViewController is UIAlertController)
    }
    
    //cellの表示に関するテスト
    func testSelectedCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
       
        let api = DummyGitHubAPI()
        vc.gitHubAPI = api
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        
        vc.loadViewIfNeeded()
        vc.tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        vc.tableView(vc.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(vc.selectedUserName, "name")
    }
}
