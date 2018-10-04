//
//  ViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var personalAccessToken: UITextField!
    
    @IBOutlet weak var caution: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
        personalAccessToken.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)

        caution.text = "If you don't have personal access token, please create via your Personal access tokens settings page. \n \n Select scope \n ☑︎rep  \n ☑︎user"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        if personalAccessToken.text!.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "personalAccessTokenを入力して下さい。", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        } else {
            
        }
        
        self.performSegue(withIdentifier: "toUserListView", sender: nil)
        
    }
    
    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let userListViewController = segue.destination as!UserListViewController
        userListViewController.accessToken = personalAccessToken.text ?? ""
        
    }
    
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        personalAccessToken.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personalAccessToken.resignFirstResponder()
         return true
    }
        

}

//4fae2eda5cd06f4c1657f9c5706211f0dad11ae4
//b9aa84c7035d9ff9a4824ee6d60ae1568830bc6e

