//
//  AccessToken.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

class AccessToken: NSObject {
    let defaults: UserDefaults
    let tokenText: String
    
    init(defaults: UserDefaults, tokenText: String) {
        self.defaults = defaults
        self.defaults.register(defaults: ["personalAccessToken": ""])
        self.tokenText = tokenText
    }
    
    //データを読み込む
    func getAccessToken() -> String {
        let token = defaults.object(forKey: "personalAccessToken") as? String
        return token ?? ""
    }
    //データを保存
    func saveAccessToken() {
        defaults.set(tokenText, forKey: "personalAccessToken")
        defaults.synchronize()
    }

}
