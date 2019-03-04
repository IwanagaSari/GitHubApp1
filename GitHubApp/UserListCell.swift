//
//  UserListCell.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/05.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageLoadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var userImageView: UIImageView!

    var task: URLSessionTask?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
    }
}
