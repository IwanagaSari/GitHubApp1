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
        defaults.register(defaults: ["personalAccessToken": ""])
        //前回保存したデータを読み込み、表示する
        personalAccessToken.text = readData()
    }
    //データを読み込む
    func readData() -> String {
        let token = defaults.object(forKey: "personalAccessToken") as? String
        return token ?? ""
    }
    //データを保存
    func saveData(str: String) {
        defaults.set(str, forKey: "personalAccessToken")
        defaults.synchronize()

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
            saveData(str: tokenText!)
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
