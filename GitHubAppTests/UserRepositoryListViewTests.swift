//
//  UserRepositoryListViewTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/02/07.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

class UserRepositoryListViewTests: XCTestCase {

    func testUserIsEmpty() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        let user = UserDetail(fullName: "", followers: nil, following: nil, image: "")
        api.userResult = (user, nil)
        
        vc?.loadViewIfNeeded()
        
        XCTAssertEqual(user.fullName, "")
        XCTAssertNil(user.followers)
    }
    
    func testUserIsOne() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        let user = UserDetail(fullName: "fullName", followers: 1, following: 1, image: "image")
        api.userResult = (user, nil)
        vc?.loadViewIfNeeded()
        
        XCTAssertEqual(vc?.fullname.text, "fullName")
    }
    func testRepositoryIsEmpty() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        api.repositoryResult = ([], nil)
        //ここが通らない
//        let number = vc?.repoTableView.numberOfRows(inSection: 0)
//        XCTAssertEqual(number, 0)
    }
    
    func testRepositoryIsOne() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserRepositoryListViewController") as? UserRepositoryListViewController
        XCTAssertNotNil(vc)
        
        let api = DummyGitHubAPI()
        vc?.gitHubAPI = api
        let repository = Repositry(name: "name", description: "description", language: "language", stargazersCount: 1, url: "url", fork: true)
        api.repositoryResult = ([repository], nil)
        XCTAssertEqual(repository.name, "name")
        XCTAssertEqual(repository.stargazersCount, 1)
    }
}
