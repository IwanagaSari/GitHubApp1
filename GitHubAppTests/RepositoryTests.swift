//
//  RepositoryTests.swift
//  GitHubAppTests
//
//  Created by 岩永 彩里 on 2019/01/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import XCTest

class RepositoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let testJson: [String: Any?] = [
            "id": 1296269,
            "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
            "name": "Hello-World",
            "full_name": "octocat/Hello-World",
            "private": false,
            "html_url": "https://github.com/octocat/Hello-World",
            "description": "This your first repo!",
            "fork": true,
            "url": "https://api.github.com/repos/octocat/Hello-World",
            "archive_url": "http://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
            "assignees_url": "http://api.github.com/repos/octocat/Hello-World/assignees{/user}",
            "blobs_url": "http://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
            "branches_url": "http://api.github.com/repos/octocat/Hello-World/branches{/branch}",
            "collaborators_url": "http://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
            "comments_url": "http://api.github.com/repos/octocat/Hello-World/comments{/number}",
            "commits_url": "http://api.github.com/repos/octocat/Hello-World/commits{/sha}",
            "compare_url": "http://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
            "contents_url": "http://api.github.com/repos/octocat/Hello-World/contents/{+path}",
            "contributors_url": "http://api.github.com/repos/octocat/Hello-World/contributors",
            "deployments_url": "http://api.github.com/repos/octocat/Hello-World/deployments",
            "downloads_url": "http://api.github.com/repos/octocat/Hello-World/downloads",
            "events_url": "http://api.github.com/repos/octocat/Hello-World/events",
            "forks_url": "http://api.github.com/repos/octocat/Hello-World/forks",
            "language": nil,
            "forks_count": 9,
            "stargazers_count": 80,
            "watchers_count": 80,
            "size": 108,
            "default_branch": "master",
            "open_issues_count": 0,
            "has_issues": true,
            "has_projects": true,
            "has_wiki": true,
            "has_pages": false,
            "has_downloads": true,
            "archived": false,
            "pushed_at": "2011-01-26T19:06:43Z",
            "created_at": "2011-01-26T19:01:12Z",
            "updated_at": "2011-01-26T19:14:43Z",
            "subscribers_count": 42,
            "network_count": 0,
        ]
        
        let name = testJson["name"] as? String
        let description = testJson["description"] as? String
        let language = testJson["language"] as? String
        let stargazersCount = testJson["stargazers_count"] as? Int
        let url = testJson["html_url"] as? String
        let fork = testJson["fork"] as? Bool
        XCTAssertEqual(name, "Hello-World")
        XCTAssertEqual(description, "This your first repo!")
        XCTAssertNil(language)
        XCTAssertEqual(stargazersCount, 80)
        XCTAssertEqual(url, "https://github.com/octocat/Hello-World")
        XCTAssertEqual(fork, true)
    }

}
