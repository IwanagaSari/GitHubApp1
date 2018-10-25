//
//  ViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak private var personalAccessToken: UITextField!
    @IBOutlet weak private var caution: UITextView!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        personalAccessToken.delegate = self

        // デフォルト値を設定
        let token = AccessToken(defaults: self.defaults, tokenText: "")
        personalAccessToken.text = token.getAccessToken()
    }

    @IBAction func enterButton(_ sender: UIButton) {
        if personalAccessToken.text!.isEmpty {
            showAlert()
        } else {
            self.performSegue(withIdentifier: "toUserListView", sender: nil)

            let tokenText = personalAccessToken.text
            let accessToken = AccessToken(defaults: self.defaults, tokenText: tokenText ?? "")
            accessToken.saveAccessToken()
        }
    }
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "personalAccessTokenを入力して下さい。", preferredStyle: UIAlertController.Style.alert)

        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let userListViewController = segue.destination as? UserListViewController
        userListViewController?.accessToken = personalAccessToken.text ?? ""
    }

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        personalAccessToken.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personalAccessToken.resignFirstResponder()
        return true
    }

}
