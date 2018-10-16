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

    //var images: [Image] = []
    //{
      //  didSet {
        //    userListTabelView.reloadData()
        //}
    //9}

    var selectedUserName: String = ""
    var selectedUserFullName: String?
    var accessToken: String = ""

    //let gitHubAPI = GitHubAPI()
    lazy var gitHubAPI = GitHubAPI(accessToken: self.accessToken)

    override func viewDidLoad() {
        super.viewDidLoad()

        userListTabelView.delegate = self
        userListTabelView.dataSource = self

        gitHubAPI.fetchUsers(completion: { users, error in
            self.users = users ?? []

            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                print("reason:\(error.localizedDescription)")
                //ここでアラートを出す
            }
        })

        //GitHubAPI.fetchImages(completion: { images, _ in
          //  self.images = images ?? []
            //print(self.images)
        //})

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //通信処理(とデータ変換)
    //class GitHubAPI {

         //func fetchImages(completion: @escaping (([Image]?, Error?) -> Void)) {
           // var req = URLRequest(url: URL(string: "https://api.github.com/users")!)
            //req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")

            //let task2: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, _, error in
              //  do {
                //let images: [Image] = try JSONDecoder().decode([Image].self, from: data!)

                //DispatchQueue.main.async { () -> Void in
                //completion(images, nil)
                //}
                //} catch {
                //print(error)
                //completion(nil, error)
                //}

            //})
            //task2.resume()
        //}

    //}

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

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")

        let user = users[indexPath.row]
        let userName = user.login
        let userImage = user.avatarUrl
        let userImageURL: URL = URL(string: "\(userImage)")!
        let imageData = try? Data(contentsOf: userImageURL)

        cell.textLabel?.text = "\(userName)"
        cell.imageView?.image = UIImage(data: imageData! )

    return cell
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //セル選択時
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let article = users[indexPath.row]
        selectedUserName = article.login

        performSegue(withIdentifier: "toUserRepositoryList", sender: IndexPath.self)
    }
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userRepositoryListViewController = segue.destination as?UserRepositoryListViewController
        userRepositoryListViewController?.nameLabel = selectedUserName
        userRepositoryListViewController?.accessToken = accessToken
    }

}
