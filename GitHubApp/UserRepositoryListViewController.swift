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
    var userName: String = ""

    var repositries: [Repositry] = [] {
        didSet {
            repoTableView.reloadData()
        }
    }
    var user: UserDetail? {
        didSet {
            repoTableView.reloadData()
        }
    }
    var selectedURL: String?

    lazy private var gitHubAPI = GitHubAPI(accessToken: self.accessToken)

    override func viewDidLoad() {
        super.viewDidLoad()

        repoTableView.delegate = self
        repoTableView.dataSource = self

        name.text = userName

        gitHubAPI.fetchUser(nameLabel: userName, completion: { user, error in
            if let error = error {
                self.showError(error)
            }
            self.user = user

            let fullName = self.user?.fullName
            self.fullname.text = fullName
            let follower: Int? = self.user?.followers
            self.follower.text = follower.flatMap { String($0) }

            let following = self.user?.following
            self.following.text = following.flatMap { String($0) }

            let userImage = self.user?.image
            if let image = userImage {
                let userImageURL: URL = URL(string: "\(image)")!
                let imageData = try? Data(contentsOf: userImageURL)
                self.imageView.image = UIImage(data: imageData!)
            } else {
                self.imageView.image = nil
            }
        })
        gitHubAPI.fetchRepositry(nameLabel: userName, completion: { repositries, error in
            if let error = error {
                self.showError(error)
            }
            self.repositries = (repositries?.filter { repo in !(repo.fork) } ?? [])
            self.reposCount.text = String(self.repositries.count)
        })
    }
    //アラートを表示する
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        print("reason:\(error.localizedDescription)")
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

        let repoStar = repository.stargazersCount
        star?.text = "\(repoStar!)"

        return cell
    }
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositries[indexPath.row]
        selectedURL = repository.url

        performSegue(withIdentifier: "toWebView", sender: IndexPath.self)
    }
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userWebViewController = segue.destination as? UserWebViewController
        userWebViewController?.webURL = selectedURL
    }
}
