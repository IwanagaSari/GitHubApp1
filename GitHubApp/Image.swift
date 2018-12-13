//
//  Image.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/11.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

final class ImageCache: NSCache<AnyObject, AnyObject> {
    static let sharedInstance = ImageCache()
    let userListCell = UserListCell()

    func fetchImage(userImageString: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        //引数で渡されたimageUrlStringがすでにキャッシュとして保存されている場合は、キャッシュからそのimageを取り出し、self.imageに代入し、returnで抜ける。

        if let imageFromCache = ImageCache.sharedInstance.object(forKey: userImageString as AnyObject) as? UIImage {
            print("キャッシュに保存されていました")
            DispatchQueue.main.async {
            completion(imageFromCache, nil)
            }
        } else {
            let userImageURL: URL = URL(string: "\(userImageString)")!
            let URLSessionTask: URLSessionTask = URLSession.shared.dataTask(with: userImageURL, completionHandler: {data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        if let imageToCache = UIImage(data: data) {
                            ImageCache.sharedInstance.setObject(imageToCache, forKey: userImageString as AnyObject)
                            print("キャッシュに保存しました")
                            completion(imageToCache, nil)
                        }
                    }
                }
            })
            userListCell.task = URLSessionTask
            URLSessionTask.resume()
        }
    }

}
