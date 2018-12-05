//
//  UserListCell.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/05.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    var task: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
    }

    func fetchImage(userImageURL: URL, completion: @escaping ((Data?, Error?) -> Void)) {
        let task: URLSessionTask = URLSession.shared.dataTask(with: userImageURL, completionHandler: {data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
        })
        self.task = task
        task.resume()
    }
}
