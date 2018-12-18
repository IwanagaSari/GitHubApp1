//
//  ImageDownloader.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/11.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

final class ImageDownloader: NSCache<AnyObject, AnyObject> {
    static let sharedInstance = ImageDownloader()

    func fetchImage(imageUrlString: String, completion: @escaping ((UIImage?, Error?) -> Void)) -> URLSessionTask? {
        //引数で渡されたimageUrlStringがすでにキャッシュとして保存されている場合は、キャッシュからそのimageを取り出し、self.imageに代入し、returnで抜ける。

        if let imageFromCache = ImageDownloader.sharedInstance.object(forKey: imageUrlString as AnyObject) as? UIImage {
            print("キャッシュに保存されていました")
            DispatchQueue.main.async { completion(imageFromCache, nil) }
            
            return nil
        } else {
            let userImageURL: URL = URL(string: "\(imageUrlString)")!
            let task = URLSession.shared.dataTask(with: userImageURL, completionHandler: {data, _, _ in
                    if let data = data {
                            if let imageToCache = UIImage(data: data) {
                                ImageDownloader.sharedInstance.setObject(imageToCache, forKey: imageUrlString as AnyObject)
                                print("キャッシュに保存しました")
                                DispatchQueue.main.async { completion(imageToCache, nil) }
                            }
                    } else {
                        let imageToCache = UIImage(named: "error")
                        DispatchQueue.main.async { completion(imageToCache, nil) }
                    }
            })
            task.resume()
            
            return task
        }
    }

}
