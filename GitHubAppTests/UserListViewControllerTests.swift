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
    
    var usersResult: ([User]?, Error?)
    var repositoryResult: ([Repositry]?, Error?)
    var userResult: (UserDetail?, Error?)
    
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        completion(self.usersResult.0, self.usersResult.1)
    }
    func fetchUser(nameLabel: String, completion: @escaping ((UserDetail?, Error?) -> Void)) {
        completion(self.userResult.0, self.userResult.1)
    }
    func fetchRepositry(nameLabel: String, completion: @escaping (([Repositry]?, Error?) -> Void)) {
        completion(self.repositoryResult.0, self.repositoryResult.1)
    }

}

class UserListViewControllerTests: XCTestCase {
    
    func testUserIsEmpty() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        
        api.usersResult = ([], nil)
        
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
        api.usersResult = ([user], nil)
        
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserListCell
        XCTAssertEqual(cell.userNameLabel.text, "name")
    }
    
    //TODO: いい方法見つけたらやる
//    func testUserIsError() {
//    }
    
    //cellの表示に関するテスト
    func testSelectedCell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
       
        let api = DummyGitHubAPI()
        vc.gitHubAPI = api
        let user = User(userName: "name", image: "image")
        api.usersResult = ([user], nil)
        
        vc.loadViewIfNeeded()
        vc.tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        vc.tableView(vc.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(vc.selectedUserName, "name")
    }
}
