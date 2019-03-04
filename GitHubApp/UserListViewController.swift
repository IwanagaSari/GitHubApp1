//
//  UserListViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var backgroundViewindicator: UIActivityIndicatorView!
    
    private var users: [User] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedUserName: String = ""
    var accessToken: String = ""
    lazy var gitHubAPI: GitHubAPIType = GitHubAPI(accessToken: self.accessToken)
    private let imageDownloader = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()

        gitHubAPI.fetchUsers(completion: { users, error in
            self.users = users ?? []

            if let error = error {
                self.showError(error)
            }
            self.backgroundViewindicator.stopAnimating()
        })        
        self.tableView.backgroundView = backgroundView
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //セルの内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! UserListCell
        let user = users[indexPath.row]
        let userName = user.userName
        let imageUrlString = user.image
        let imageUrl = URL(string: imageUrlString)!
        cell.userImageLoadingIndicator.startAnimating()

        let task = imageDownloader.fetchImage(url: imageUrl, completion: { imageToCache, error in
            if error != nil {
                cell.userImageView.image = UIImage(named: "error")
            } else {
                cell.userImageView.image = imageToCache
            }
            cell.userImageLoadingIndicator.stopAnimating()
        })
        cell.task = task
        
        cell.userNameLabel.text = "\(userName)"

        return cell
    }
    
    //セル選択時
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        selectedUserName = user.userName
        performSegue(withIdentifier: "toUserRepositoryList", sender: IndexPath.self)
    }
    
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userRepositoryListViewController = segue.destination as? UserRepositoryListViewController
        userRepositoryListViewController?.userName = selectedUserName
        userRepositoryListViewController?.accessToken = accessToken
    }
}
