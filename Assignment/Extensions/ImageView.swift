//
//  ImageView.swift
//  CodeChallenge
//
//  Created by Niranjan on 01/05/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()
   private let kLazyLoadMaxCacheImageSize = 20
extension UIImageView {
       func cacheImage(_ image: UIImage, forURL url: String) {
           if imageCache.count > kLazyLoadMaxCacheImageSize { // free old images first.
               imageCache.remove(at: imageCache.startIndex)
           }
           imageCache[url] = image
       }
   public func downloadImageFromURL(_ urlString: String) {
           if let cachedImage = cachedImageForURL(urlString) {
               self.image = cachedImage
               return
           }else{
             self.image = UIImage(named: "placeholder")
            }
            if let url = URL(string: urlString) { // download from URL asynchronously
            let session = URLSession.shared
            let downloadTask = session.downloadTask(with: url, completionHandler: { (retrievedURL, _, error) -> Void in
                if error != nil { print("Error downloading image \(url.absoluteString): \(error!.localizedDescription)") } else if retrievedURL != nil {
                    if let data = try? Data(contentsOf: retrievedURL!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async(execute: {
                            if let downloadedImage = UIImage(data: data) {
                                self.cacheImage(image, forURL: url.absoluteString)
                                self.image = downloadedImage
                            }
                        })
                        }
                    }
                }

            })
            downloadTask.resume()
        }
    }
    func cachedImageForURL(_ url: String) -> UIImage? { return imageCache[url] }
    func clearCache() { imageCache.removeAll() }
}
