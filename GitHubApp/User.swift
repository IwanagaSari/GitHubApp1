//
//  User.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case image = "avatar_url"
    }
}

struct UserDetail: Codable {
    let fullName: String?
    let followers: Int?
    let following: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case followers
        case following
        case image = "avatar_url"
    }
}
