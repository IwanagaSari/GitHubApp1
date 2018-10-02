//
//  ViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var personalAccessToken: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

//4fae2eda5cd06f4c1657f9c5706211f0dad11ae4

