//
//  InputTokenViewController.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class InputTokenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak private(set) var personalAccessToken: UITextField!
    @IBOutlet weak private(set) var caution: UITextView!
    @IBOutlet weak private(set) var enterButton: UIButton!
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        personalAccessToken.delegate = self

        // デフォルト値を設定
        let token = Setting(defaults: self.defaults)
        personalAccessToken.text = token.token
    }

    @IBAction private func enterButton(_ sender: UIButton) {
        if personalAccessToken.text!.isEmpty {
            showTokenConfirmationAlert()
        } else {
            self.performSegue(withIdentifier: "toUserListView", sender: nil)

            let tokenText = personalAccessToken.text
            let accessToken = Setting(defaults: self.defaults)
            accessToken.token = tokenText ?? ""
        }
    }
    private func showTokenConfirmationAlert() {
        let alertController = UIAlertController(title: "Error", message: "personalAccessTokenを入力して下さい。", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    //次のページへ値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let userListViewController = segue.destination as? UserListViewController
        userListViewController?.accessToken = personalAccessToken.text ?? ""
    }

    @IBAction private func tapView(_ sender: UITapGestureRecognizer) {
        personalAccessToken.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { 
        personalAccessToken.resignFirstResponder()
        return true
    }
}
