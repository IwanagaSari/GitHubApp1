//
//  APIError.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

struct ErrorData: Codable, LocalizedError {
    let message: String

    var errorDescription: String? {
        return message
    }
}
