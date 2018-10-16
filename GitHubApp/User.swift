//
//  User.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

struct UserDetail: Codable {
    let name: String?
    let followers: Int?
    let following: Int?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case name
        case followers
        case following
        case avatarUrl = "avatar_url"
    }
}
