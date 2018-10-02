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
    
    var accessToken :String = ""
    var nameLabel : String?
    
    var repositries: [[String: Any]] = []{
        didSet {
            repoTableView.reloadData()
        }
    }
    var json2: [Any] = []
    var articles2: [[String: Any]] = []
    
    var articles1: [String: Any] = [:]{
        didSet {
            repoTableView.reloadData()
        }
    }
    var json1: [String: Any] = [:]
    
    var selectedURL: String?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        //セルの高さを自動で計算
        self.repoTableView.estimatedRowHeight = 135
        repoTableView.rowHeight = UITableViewAutomaticDimension
        
        fullname.numberOfLines = 0
        
        //二つの非同期処理
        let dispatchGroup = DispatchGroup()
        let dispatchQueue1 = DispatchQueue(label: "user情報取得", attributes: .concurrent)
        let dispatchQueue2 = DispatchQueue(label: "repo情報取得", attributes: .concurrent)
        
        var req = URLRequest(url: URL(string: "https://api.github.com/users/\(nameLabel!)")!)
        req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        let repoURL: URL = URL(string: "\(req)/repos")!
        
        dispatchGroup.enter()
        dispatchQueue1.async(group: dispatchGroup) {
        //処理１
        [weak self] in
        queue1()
        }        
        dispatchQueue2.async(group: dispatchGroup) {
        //処理２
        [weak self] in
        queue2()
        }
        dispatchGroup.leave()
        
        //DispatchQueue.main.async() { () -> Void in
            //print("完了")
            
       // }

        func queue1(){
            print("queue1")
            let task: URLSessionTask = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
              do {
                self.json1 = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)as! [String: Any]
                
                DispatchQueue.main.async() { () -> Void in
                    self.articles1 = self.json1
                    
                    let fullNameLabel = self.articles1["name"] as? String
                    self.fullname.text = fullNameLabel
                    let follower = self.articles1["followers"] as? Int
                        self.follower.text = "\(follower!)"
                    
                    let following = self.articles1["following"] as? Int
                    self.following.text = "\(following!)"
                    
                    let userImage = self.articles1["avatar_url"] as? String ?? ""
                    let userImageURL: URL = URL(string: "\(userImage)")!
                    let imageData = try? Data(contentsOf: userImageURL)
                    self.imageView.image = UIImage(data: imageData!)
                }
              }
              catch {
              print(error)
              }
            })
            task.resume() //実行する
        }
        
        func queue2(){
        let task2: URLSessionTask = URLSession.shared.dataTask(with: repoURL, completionHandler: {data, response, error in
            do {
                self.json2 = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)as! [Any]
                
                self.articles2 = (self.json2.map { (article) -> [String: Any] in
                    return article as! [String: Any]
                })
                
                DispatchQueue.main.async() { () -> Void in
                    self.repositries = self.articles2
                    self.reposCount.text = String(self.repositries.count)
                }
            }
            catch{
                print(error)
            }
        })
        task2.resume() //実行する
        }
     
        
        //let repositrie = repositries[indexPath.row]
        //let nonforked = repositries["fork"] as! String
        //if let fork = repositries[1]["fork"]  {
           // if fork = "false"{
             //   print("nonforked")
            //}
            
        //}
        
        name.text = nameLabel
        
        // Do any additional setup after loading the view.
    }
    //行数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return repositries.count
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セルの高さ
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //}
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //moneyfowardパソコン
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
        //myパソコン
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        let cell = repoTableView.dequeueReusableCell(withIdentifier: "userCell")!
        let repository = repositries[indexPath.row]
        
        let repoLabel = cell.viewWithTag(1) as! UILabel
        let description = cell.viewWithTag(2) as! UILabel
        
        let language = cell.viewWithTag(3) as! UILabel
        let star = cell.viewWithTag(4) as! UILabel
        //行数を可変に設定
        description.numberOfLines = 0
        
        let repoName = repository["name"] as! String
        repoLabel.text = "\(repoName)"
        
        let repoDescription = repository["description"]
        if let repoDes = repoDescription {
        description.text = "\(repoDes)"
        }
        
        let  repoLanguage = repository["language"]
        if let repoLan = repoLanguage {
            language.text = "\(repoLan)"
        }
        
        let repoStar = repository["stargazers_count"]
        if let repoSta = repoStar {
            star.text = "\(repoSta)"
        }

        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repository = repositries[indexPath.row]
        selectedURL = repository["clone_url"] as? String
        
        performSegue(withIdentifier: "toWebView", sender: IndexPath.self)
        
    }
    
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userWebViewController = segue.destination as!UserWebViewController
        userWebViewController.webURL = selectedURL
        
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
