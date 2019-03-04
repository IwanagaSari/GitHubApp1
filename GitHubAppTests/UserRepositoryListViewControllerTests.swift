//
//  UserRepositoryListViewControllerTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/02/07.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class UserRepositoryListViewControllerTests: XCTestCase {
    private let api = DummyGitHubAPI()
    private var vc: UserRepositoryListViewController!
    
    override func setUp() {
        super.setUp()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        vc.gitHubAPI = api
    }

    func testUserIsEmpty() {
        let user = UserDetail(fullName: "", followers: nil, following: nil, image: "")
        api.userResult = (user, nil)
        
        XCTAssertEqual(user.fullName, "")
        XCTAssertNil(user.followers)
    }
    
    func testUserIsOne() {
        let user = UserDetail(fullName: "fullName", followers: 1, following: 1, image: "image")
        api.userResult = (user, nil)
        vc?.loadViewIfNeeded()
        
        XCTAssertEqual(vc?.fullnameLabel.text, "fullName")
    }
    
    func testRepositoryIsEmpty() {
        api.repositoryResult = ([], nil)
        vc?.loadViewIfNeeded()
        
        let number = vc?.repoTableView.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 0)
    }
    
    func testRepositoryIsOne() {
        let repository = Repositry(name: "name", description: "description", language: "language", stargazersCount: 1, url: "url", fork: true)
        api.repositoryResult = ([repository], nil)
        vc?.loadViewIfNeeded()
        
        XCTAssertEqual(repository.name, "name")
        XCTAssertEqual(repository.stargazersCount, 1)
    }
}
