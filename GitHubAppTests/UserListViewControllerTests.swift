//
//  UserListViewControllerTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

protocol GitHubAPIType {
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void))
} //GitHubAPIのファイルに書くらしい。

class DummyGitHubAPI: GitHubAPIType {
    
    var userResult: ([User]?, Error?)
    
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        completion(userResult.0, userResult.1)
    }
}

class UserListViewControllerTests: XCTestCase {
    
    func testUserListView1(completion: @escaping (([User]?, Error?) -> Void)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let dummyGitHubAPI = DummyGitHubAPI()
        let empty: ([User]?, Error?) = ([], nil)
        dummyGitHubAPI.userResult = empty
        
        vc?.loadViewIfNeeded()
        
        let cell = vc?.tableView.visibleCells[0] as! UserListCell
        
        dummyGitHubAPI.fetchUsers(completion: { users, error in
            let user = users?[0]
            XCTAssertEqual(cell.userNameLabel.text, user?.userName)
        })
    }
    
    func testUserListView2(completion: @escaping (([User]?, Error?) -> Void)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        let dummyGitHubAPI = DummyGitHubAPI()
        
        let user = User(userName: "name", image: "image")
        let fourUsers: ([User]?, Error?) = ([user, user, user, user], nil)
        dummyGitHubAPI.userResult = fourUsers
        
        vc?.loadViewIfNeeded()
        
        dummyGitHubAPI.fetchUsers(completion: { users, error in
            let cell = vc?.tableView.visibleCells[3] as! UserListCell
            let user3 = users?[3]
            XCTAssertEqual(cell.userNameLabel.text, user3?.userName)
        })
    }
}
