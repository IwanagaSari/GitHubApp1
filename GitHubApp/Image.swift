//
//  Image.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/11.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

class Image {

    var task: URLSessionTask?
    let imageCache = NSCache<AnyObject, AnyObject>()
    var image: UIImage?

    func fetchImage(userImageString: String, completion: @escaping ((UIImage?, Error?) -> Void)) {
        //引数で渡されたimageUrlStringがすでにキャッシュとして保存されている場合は、キャッシュからそのimageを取り出し、self.imageに代入し、returnで抜ける。
        if let imageFromCache = imageCache.object(forKey: userImageString as AnyObject) as? UIImage {
            self.image = imageFromCache
            print("キャッシュに保存されていました")
            completion(self.image, nil)
            //return
        } else {
        let userImageURL: URL = URL(string: "\(userImageString)")!
        let URLSessionTask: URLSessionTask = URLSession.shared.dataTask(with: userImageURL, completionHandler: {data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.image = imageToCache
                    self.imageCache.setObject(imageToCache!, forKey: userImageString as AnyObject)
                    print("キャッシュに保存しました")
                    completion(self.image, nil)
                }
            }
        })
        task = URLSessionTask
        URLSessionTask.resume()
        }

    }

}
