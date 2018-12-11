//
//  UserListViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userListTabelView: UITableView!

    var users: [User] = [] {
        didSet {
            userListTabelView.reloadData()
        }
    }

    var selectedUserName: String = ""
    var accessToken: String = ""

    lazy private var gitHubAPI = GitHubAPI(accessToken: self.accessToken)

    private let activityIndicatorView = UIActivityIndicatorView()
    let userListCell = UserListCell()
    let image = Image()

    override func viewDidLoad() {
        super.viewDidLoad()

        userListTabelView.delegate = self
        userListTabelView.dataSource = self

        gitHubAPI.fetchUsers(completion: { users, error in
            self.users = users ?? []

            if let error = error {
                self.showError(error)
            }
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
        })
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .purple
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
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
        return users.count
    }
     //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! UserListCell

        let user = users[indexPath.row]
        let userName = user.userName
        let userImageString = user.image

        image.fetchImage(userImageString: userImageString, completion: { imageToCache, _ in
                cell.imageView?.image = imageToCache
        })

        cell.textLabel?.text = "\(userName)"
        cell.imageView?.image = UIImage(named: "loading")

        return cell
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //セル選択時
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
