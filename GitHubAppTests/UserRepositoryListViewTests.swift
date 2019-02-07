//
//  UserRepositoryListViewTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/02/07.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

//class DummyGitHubAPI: GitHubAPITypeが入る {
//
//    var userResult: (UserDetail?, Error?)
//
//    func fetchUser(completion: @escaping ((UserDetail?, Error?) -> Void)) {
//        completion(self.userResult.0, self.userResult.1)
//    }
//
//}

class UserRepositoryListViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testUserIsEmpty() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        //let api = DummyGitHubAPI()
        //        vc?.gitHubAPI = api
        //
        //        api.userResult = ([], nil)
        //
        //        vc?.loadViewIfNeeded()
        //
        //        let number = vc?.tableView.numberOfRows(inSection: 0)
        //        XCTAssertEqual(number, 0)
    }
    
    func testUserIsOne() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
//        let api = DummyGithubAPI()
//        vc?.loadViewIfNeeded()
//
//        let number = vc?.repoTableView.numberOfRows(inSection: 0)
//        XCTAssertEqual(number, 1)
//
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = vc?.repoTableView.cellForRow(at: indexPath)
        
    }

}
