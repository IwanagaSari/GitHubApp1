//
//  UserWebViewController.swift
//  GitHubApp
//
//  Created by 岩永彩里 on 2018/10/02.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserWebViewController: UIViewController, UIWebViewDelegate {
    
    var webURL: String?
   
    @IBOutlet weak var userWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userWebView.delegate = self
        
        let myURL = URL(string: "\(webURL!)")
        let myURLRequest = URLRequest(url: myURL!)
        
        print(myURLRequest)
        userWebView.loadRequest(myURLRequest)

        // Do any additional setup after loading the view.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //インジケータを表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {        
        //3.インジケータを非表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    @IBAction func backButton(_ sender: UIButton) {
        userWebView.goBack()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        userWebView.goForward()
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        userWebView.reload()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        userWebView.stopLoading()
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
