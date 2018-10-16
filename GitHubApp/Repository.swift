//
//  Repository.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

    struct Repositry: Codable {
        let name: String?
        let description: String?
        let language: String?
        let stargazersCount: Int?
        let cloneUrl: String
        let fork: Bool

        enum CodingKeys: String, CodingKey {
            case name
            case description
            case language
            case stargazersCount = "stargazers_count"
            case cloneUrl = "clone_url"
            case fork
        }
    }
