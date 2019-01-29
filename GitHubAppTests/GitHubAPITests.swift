//
//  GitHubAPITests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/28.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest
@testable import GitHubApp

protocol GitHubAPIType {
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void))
}

class DummyGitHubAPI: GitHubAPIType {
    
    var userResult: ([User]?, Error?) //= empty
    
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        completion(userResult.0, userResult.1)
    }
    
}

class GitHubAPITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        let dummyGitHubAPI = DummyGitHubAPI()
        let empty: ([User]?, Error?) = ([], nil)
        dummyGitHubAPI.userResult = empty
        
        dummyGitHubAPI.fetchUsers(completion: { users, error in
            let usersCount = users?.count
            XCTAssertNil(error)
            XCTAssertEqual(usersCount, 0)            
        })
    }

}
