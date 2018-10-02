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
    
    var articles: [[String: Any]] = []{
        didSet {
            userListTabelView.reloadData()
        }
    }
    var selectedUserName :String?
    var selectedUserFullName :String?
    var accessToken :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTabelView.delegate = self
        userListTabelView.dataSource = self
        
        
        var req = URLRequest(url: URL(string: "https://api.github.com/users")!)
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            do {
                //print(String(data: data!, encoding: .utf8))
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                
                let articles = json.map { (article) -> [String: Any] in
                    return article as! [String: Any]
                }
                DispatchQueue.main.async() { () -> Void in
                self.articles = articles
                    
                    //print("image: \(articles[0]["avatar_url"])")
                }
            
            }
            catch {
                print(error)
            }
        
        })
        task.resume() //実行する
        // Do any additional setup after loading the view.
    }
    
    //行数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return articles.count
    }
     //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //moneyfowardパソコン
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
        
        //myパソコン
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        
        let article = articles[indexPath.row]
        let userName = article["login"] as! String
        let userImage = article["avatar_url"] as! String
        let userImageURL: URL = URL(string: "\(userImage)")!
        let imageData = try? Data(contentsOf: userImageURL)
        
        cell.textLabel?.text = "\(userName)"
        cell.imageView?.image = UIImage(data: imageData!)
    
    return cell
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    //セル選択時
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles[indexPath.row]
        selectedUserName = article["login"] as? String
        
        performSegue(withIdentifier: "toUserRepositoryList", sender: IndexPath.self)
        
    }
    
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let userRepositoryListViewController = segue.destination as!UserRepositoryListViewController
        userRepositoryListViewController.nameLabel = selectedUserName
        userRepositoryListViewController.accessToken = accessToken
        
        
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
