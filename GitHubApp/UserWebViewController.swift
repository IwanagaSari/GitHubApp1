//
//  UserWebViewController.swift
//  GitHubApp
//
//  Created by 岩永彩里 on 2018/10/02.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit
import WebKit

class UserWebViewController: UIViewController {
    
    var webURL: String?
   
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "\(webURL!)")
        let myURLRequest = URLRequest(url: myURL!)
        
        print(myURLRequest)
        webView.load(myURLRequest)
    
        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        webView.reload()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        webView.stopLoading()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
