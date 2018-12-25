//
//  ImageDownloader.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/12/11.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

final class ImageDownloader: NSCache<AnyObject, AnyObject> {
    static let shared = ImageDownloader()

    func fetchImage(imageUrlString: String, completion: @escaping ((UIImage?, Error?) -> Void)) -> URLSessionTask? {
        //キャッシュとして保存されている場合
        if let imageFromCache = ImageDownloader.shared.object(forKey: imageUrlString as AnyObject) as? UIImage {
            DispatchQueue.main.async { completion(imageFromCache, nil) }
            return nil
        //キャッシュとして保存されていなかった場合
        } else {
            let userImageURL = URL(string: imageUrlString)!
            let task = URLSession.shared.dataTask(with: userImageURL, completionHandler: {data, _, error in
                    if let data = data {
                        if let imageToCache = UIImage(data: data) {
                            ImageDownloader.shared.setObject(imageToCache, forKey: imageUrlString as AnyObject)
                            DispatchQueue.main.async { completion(imageToCache, nil) }
                        }
                    } else {
                        //
                        DispatchQueue.main.async { completion(nil, error) }
                    }
            })
            task.resume()
            return task
        }
    }
}
