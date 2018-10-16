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
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        personalAccessToken.delegate = self

        // デフォルト値を設定

        let token = AccessToken(defaults: self.defaults, tokenText: "")
        personalAccessToken.text = token.readData()
    }
    //アクセストークンを取得するクラス
    class AccessToken {
        let defaults: UserDefaults
        let tokenText: String

        init(defaults: UserDefaults, tokenText: String) {
            self.defaults = defaults
            self.defaults.register(defaults: ["personalAccessToken": ""])
            self.tokenText = tokenText
        }

        //データを読み込む
        func readData() -> String {
            let token = defaults.object(forKey: "personalAccessToken") as? String
            return token ?? ""
        }
        //データを保存
        func saveData() {
            defaults.set(tokenText, forKey: "personalAccessToken")
            defaults.synchronize()
        }
    }

    @IBAction func enterButton(_ sender: UIButton) {
        if personalAccessToken.text!.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "personalAccessTokenを入力して下さい。", preferredStyle: UIAlertController.Style.alert)

            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "toUserListView", sender: nil)

            let tokenText = personalAccessToken.text
            let token = AccessToken(defaults: self.defaults, tokenText: tokenText ?? "")
            token.saveData()
        }

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
