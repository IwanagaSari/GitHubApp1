//
//  UserWebViewController.swift
//  GitHubApp
//
//  Created by 岩永彩里 on 2018/10/02.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit
import WebKit

class UserWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webURL: String?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "\(webURL!)")
        let myURLRequest = URLRequest(url: myURL!)

        webView.load(myURLRequest)
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }

    @IBAction func backButton(_ sender: UIButton) {
        webView.goBack()
    }

    @IBAction func pressButton(_ sender: UIButton) {
        webView.goForward()
    }

    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
 
}
