//
//  UserRepositoryListViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit
import SafariServices

class UserRepositoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var numberOfFollowersLabel: UILabel!
    @IBOutlet weak var numberOfFollowingsLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var countOfRepositoriesLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var userRepositoriesIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userImageIndicator: UIActivityIndicatorView!
    
    var accessToken: String = ""
    var username: String = ""

    private var repositries: [Repositry] = [] {
        didSet {
            repoTableView.reloadData()
        }
    }
    private var user: UserDetail? {
        didSet {
            repoTableView.reloadData()
        }
    }
    lazy var gitHubAPI: GitHubAPIType = GitHubAPI(accessToken: self.accessToken)
    private let imageCache = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()

        repoTableView.delegate = self
        repoTableView.dataSource = self

        usernameLabel.text = username

        gitHubAPI.fetchUser(nameLabel: username, completion: { user, error in
            if let error = error {
                self.showError(error)
            }
            self.user = user

            let fullname = self.user?.name
            self.fullnameLabel.text = fullname
            let follower: Int? = self.user?.followers
            self.numberOfFollowersLabel.text = follower.flatMap { String($0) }

            let following = self.user?.following
            self.numberOfFollowingsLabel.text = following.flatMap { String($0) }

            let imageUrlString = self.user?.image
            let imageUrl = URL(string: imageUrlString ?? "")
            if let imageUrl =  imageUrl {
                _ = self.imageCache.fetchImage(url: imageUrl, completion: { imageToCache, _ in
                    self.userImageView.image = imageToCache
                })
            } else {
                    self.userImageView.image = nil
            }
            self.userImageIndicator.stopAnimating()
        })
        gitHubAPI.fetchRepositry(nameLabel: username, completion: { repositries, error in
            if let error = error {
                self.showError(error)
            }
            self.repositries = (repositries?.filter { repo in !(repo.fork) } ?? [])
            self.countOfRepositoriesLabel.text = String(self.repositries.count)
            self.userRepositoriesIndicator.stopAnimating()
        })
        repoTableView.backgroundView = backgroundView
        
        self.repoTableView.register(UINib(nibName: "RepositoryListCell", bundle: nil), forCellReuseIdentifier: "RepositoryListCell")
    }
    
    //アラートを表示する
    private func showError(_ error: Error) {
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
    
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = repoTableView.dequeueReusableCell(withIdentifier: "RepositoryListCell") as! RepositoryListCell
        let repository = repositries[indexPath.row]

        let repoName = repository.name
        cell.repositoryNameLabel.text = repoName

        let repoDescription = repository.description
        cell.descriptionLabel.text = repoDescription

        let  repoLanguage = repository.language
        cell.languageLabel.text = repoLanguage

        let repoStar = repository.stargazersCount
        cell.countOfStarsLabel.text = "\(repoStar!)"

        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositries[indexPath.row]
        
        if let repositoryURL = URL(string: "\(repository.url)") {
            let safari = SFSafariViewController(url: repositoryURL)
            present(safari, animated: true, completion: nil)
        }
    }
}
