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
            completion(self.userResult.0, self.userResult.1)
    }

}

class UserListViewControllerTests: XCTestCase {
    
    private let api = DummyGitHubAPI()
    private var vc: UserListViewController!
    
    override func setUp() {
        super.setUp()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
        XCTAssertNotNil(vc)
        
        vc?.gitHubAPI = api
    }
    
    /// Userが空でかえってきた時のテスト
    func testUserIsEmpty() {
        api.userResult = ([], nil)
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 0)
    }
    
    /// Userが一人かえってきた時のテスト
    func testUserIsOne() {
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        vc?.loadViewIfNeeded()
        
        let number = vc?.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 1)
        
        let cell = vc?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserListCell
        XCTAssertEqual(cell.userNameLabel.text, "name")
    }
    
    /// cellが選択された時のテスト
    func testSelectedCell() {
        let user = User(userName: "name", image: "image")
        api.userResult = ([user], nil)
        vc.loadViewIfNeeded()
        vc.tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        vc.tableView(vc.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(vc.selectedUserName, "name")
    }
    
    //TODO: いい方法見つけたらやる
    //    func testUserIsError() {
    //    }
    
}
