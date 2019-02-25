//
//  GitHubAPI.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation
import  UIKit

protocol GitHubAPIType {
    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void))
    func fetchUser(nameLabel: String, completion: @escaping ((UserDetail?, Error?) -> Void))
    func fetchRepositry(nameLabel: String, completion: @escaping (([Repositry]?, Error?) -> Void))
}

class GitHubAPI: GitHubAPIType {
    
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    private func fetchResponse<ResponseType: Decodable>(request: URLRequest, completion: @escaping ((ResponseType?, Error?) -> Void)) {
        var req = request
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            //通信上のエラー処理
            if let error = error {  //このエラーはdetaTaskのエラー
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            // API上のエラー処理
            if let response = response as? HTTPURLResponse { //通信上のエラーがある場合はresponseはnil
                print("response.statusCode1 = \(response.statusCode)")
                //print(String(data: data!, encoding: .utf8))
                if response.statusCode >= 300 || response.statusCode < 200 {
                    do {
                        let dataMessage = try JSONDecoder().decode(APIError.self, from: data!)
                        print("test:\(dataMessage.localizedDescription)")
                        //print("test2:\(dataMessage.message)")こっちでもいいのか？
                        DispatchQueue.main.async { completion(nil, dataMessage) }
                    } catch {
                        print(error)
                        DispatchQueue.main.async { completion(nil, error) }
                    }
                }
            }
            do {
                let response = try JSONDecoder().decode(ResponseType.self, from: data!)
                DispatchQueue.main.async { completion(response, nil) }
            } catch let error {
                print(error)
                DispatchQueue.main.async { completion(nil, error) }  //user取得時のJSONデコード時のエラー
            }
        })
        task.resume()
    }

    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        let req = URLRequest(url: URL(string: "https://api.github.com/users")!)
        fetchResponse(request: req, completion: completion)
        
    }

    func fetchUser(nameLabel: String, completion: @escaping ((UserDetail?, Error?) -> Void)) {
        let req = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel)")!)
        fetchResponse(request: req, completion: completion)
    }

    func fetchRepositry(nameLabel: String, completion: @escaping (([Repositry]?, Error?) -> Void)) {
        let req = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel)/repos")!)
        fetchResponse(request: req, completion: completion)
    }
}
