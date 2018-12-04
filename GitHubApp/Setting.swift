//
//  Setting.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

final class Setting {
    private let defaults: UserDefaults

    private static let personalAccessToken: String = "personalAccessToken"

    var token: String {
        get {
            let token = defaults.object(forKey: type(of: self).personalAccessToken) as? String
            return token ?? ""  //ここでデフォルト値も設定される
        }
        set {
            defaults.set(newValue, forKey: type(of: self).personalAccessToken)
            defaults.synchronize()
        }
    }

    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}
