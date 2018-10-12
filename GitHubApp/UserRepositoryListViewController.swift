//
//  UserRepositoryListViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserRepositoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var follower: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var reposCount: UILabel!

    var accessToken: String = ""
    var nameLabel: String = ""

    struct User: Codable {
        let name: String?
        let followers: Int?
        let following: Int?
        let avatar_url: String?
    }

    struct Repositry: Codable {
        let name: String?
        let description: String?
        let language: String?
        let stargazers_count: Int?
        let clone_url: String
        let fork: Bool
    }

    var repositries: [Repositry] = [] {
        didSet {
            repoTableView.reloadData()
        }
    }
    var user: User = User(name: nil, followers: nil, following: nil, avatar_url: nil) {
        didSet {
            repoTableView.reloadData()
        }
    }
    var selectedURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        repoTableView.delegate = self
        repoTableView.dataSource = self

        //セルの高さを自動で計算
        self.repoTableView.estimatedRowHeight = 135
        repoTableView.rowHeight = UITableView.automaticDimension
        //repoTableView.rowHeight = UITableViewAutomaticDimension

        fullname.numberOfLines = 0
        fullname.textColor = UIColor.white
        follower.textColor = UIColor.white
        following.textColor = UIColor.white
        name.text = nameLabel

        let api = GitHubAPI(accessToken: self.accessToken, nameLabel: self.nameLabel)

        api.fetchUser(completion: { user, _ in
            self.user = user ?? User(name: nil, followers: nil, following: nil, avatar_url: nil)

            let fullNameLabel = self.user.name
            self.fullname.text = fullNameLabel
            let follower: Int? = self.user.followers
            self.follower.text = follower.flatMap { String($0) }

            let following = self.user.following
            self.following.text = following.flatMap { String($0) }

            let userImage = self.user.avatar_url
            if let image = userImage {
                let userImageURL: URL = URL(string: "\(image)")!
                let imageData = try? Data(contentsOf: userImageURL)
                self.imageView.image = UIImage(data: imageData!)
            } else {
                self.imageView.image = nil
            }

        })
        api.fetchRepositry(completion: { repositries, _ in
            self.repositries = (repositries?.filter { repo in !(repo.fork) } ?? [])
            self.reposCount.text = String(self.repositries.count)

        })
    }
    class GitHubAPI {
        private let accessToken: String
        var nameLabel: String?

        init(accessToken: String, nameLabel: String) {
            self.accessToken = accessToken
            self.nameLabel = nameLabel
        }

    func fetchUser (completion: @escaping ((User?, Error?) -> Void)) {
        var req = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel!)")!)
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            if let response = response as? HTTPURLResponse {
                print("response.statusCode2 = \(response.statusCode)")
            }
            do {
                let user: User = try JSONDecoder().decode(User.self, from: data!)

                DispatchQueue.main.async { () -> Void in
                    completion(user, nil)
                }
            } catch {
              print(error)
              completion(nil, error)
            }
        })
        task.resume() //実行する
    }

    func fetchRepositry(completion: @escaping (([Repositry]?, Error?) -> Void)) {
        var repoURL = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel!)/repos")!)
        repoURL.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

        let task2: URLSessionTask = URLSession.shared.dataTask(with: repoURL, completionHandler: {data, response, error in
            if let response = response as? HTTPURLResponse {
                print("response.statusCode3 = \(response.statusCode)")
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
        task2.resume() //実行する
    }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //行数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositries.count
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = repoTableView.dequeueReusableCell(withIdentifier: "userCell")!

        let repository = repositries[indexPath.row]

        let repoLabel = cell.viewWithTag(1) as? UILabel
        let description = cell.viewWithTag(2) as? UILabel
        let language = cell.viewWithTag(3) as? UILabel
        let star = cell.viewWithTag(4) as? UILabel

        let repoName = repository.name
        repoLabel?.text = repoName

        let repoDescription = repository.description
        description?.text = repoDescription

        let  repoLanguage = repository.language
        language?.text = repoLanguage

        let repoStar = repository.stargazers_count
        star?.text = "\(repoStar!)"

        return cell
    }

    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let repository = repositries[indexPath.row]
        selectedURL = repository.clone_url

        performSegue(withIdentifier: "toWebView", sender: IndexPath.self)

    }

    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userWebViewController = segue.destination as? UserWebViewController
        userWebViewController?.webURL = selectedURL

    }
}
