//
//  GitHubAPI.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/10/16.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import Foundation

class GitHubAPI: NSObject {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func fetchUsers(completion: @escaping (([User]?, Error?) -> Void)) {
        var req = URLRequest(url: URL(string: "https://api.github.com/users")!)
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            //通信上のエラー処理
            if let error = error {  //このエラーはdetaTaskのエラー
                completion(nil, error)
                return
            }
            // API上のエラー処理
            if let response = response as? HTTPURLResponse { //通信上のエラーがある場合はresponseはnil
                print("response.statusCode1 = \(response.statusCode)")
                //print(String(data: data!, encoding: .utf8))
                if response.statusCode >= 300 {
                    do {
                        let dataMessage: APIError = try JSONDecoder().decode(APIError.self, from: data!)
                        print("test:\(dataMessage.localizedDescription)")
                        completion(nil, dataMessage)
                    } catch {
                        print(error)
                        completion(nil, error)
                    }
                }
            }
            do {
                let users: [User] = try JSONDecoder().decode([User].self, from: data!)

                DispatchQueue.main.async { () -> Void in
                    completion(users, nil)
                }

            } catch let error {
                print(error)
                completion(nil, error)  //user取得時のJSONデコード時のエラー

            }
        })
        task.resume()
    }

    func fetchUser (nameLabel: String, completion: @escaping ((UserDetail?, Error?) -> Void)) {
        var req = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel)")!)
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in

            if let error = error {
                completion(nil, error)
                return
            }
            if let response = response as? HTTPURLResponse {
                print("response.statusCode2 = \(response.statusCode)")

                if response.statusCode >= 300 {
                    do {
                        let dataMessage: APIError = try JSONDecoder().decode(APIError.self, from: data!)
                        print("test:\(dataMessage.localizedDescription)")
                        completion(nil, dataMessage)
                    } catch {
                        print(error)
                        completion(nil, error) //
                    }
                }
            }
            do {
                let user: UserDetail = try JSONDecoder().decode(UserDetail.self, from: data!)

                DispatchQueue.main.async { () -> Void in
                    completion(user, nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        })
        task.resume()
    }

    func fetchRepositry(nameLabel: String, completion: @escaping (([Repositry]?, Error?) -> Void)) {
        var repoURL = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel)/repos")!)
        repoURL.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task2: URLSessionTask = URLSession.shared.dataTask(with: repoURL, completionHandler: {data, response, error in
            if let error = error {  //このエラーはdetaTaskのエラー
                completion(nil, error)
                return
            }
            if let response = response as? HTTPURLResponse {
                print("response.statusCode3 = \(response.statusCode)")

                if response.statusCode >= 300 {
                    do {
                        let dataMessage: APIError = try JSONDecoder().decode(APIError.self, from: data!)
                        print("test:\(dataMessage.localizedDescription)")
                        completion(nil, dataMessage)
                    } catch {
                        print(error)
                        completion(nil, error)
                    }
                }
            }
            do {
                let repositries: [Repositry] = try JSONDecoder().decode([Repositry].self, from: data!)

                DispatchQueue.main.async { () -> Void in
                    completion(repositries, nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        })
        task2.resume()
    }
}
