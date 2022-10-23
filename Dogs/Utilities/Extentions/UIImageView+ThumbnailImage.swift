//
//  UIImageView+ThumbnailImage.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/13/22.
//

import Foundation
import UIKit


// NSCache is faster for access since it is in memory.
// But the cache data will be removed if the device is restart or app restart
// URLCache is both in memory and disk
// TODO: Migrate from NSCache to URLCache
// https://medium.com/@master13sust/to-nscache-or-not-to-nscache-what-is-the-urlcache-35a0c3b02598
// https://levelup.gitconnected.com/image-caching-with-urlcache-4eca5afb543a

let imageCache = NSCache<NSString,UIImage>()

extension UIImageView{
    
    func cachedImageAvailableFor(key: String) -> Bool{
        
        if let image = imageCache.object(forKey: NSString(string: key)) {
            self.image = image
            return false
        }
        return true
    }
    
    @discardableResult
    func loadImageFrom(_ urlString:String, _ placeholderImage: UIImage? = nil, _ cachedKey: String? = nil) -> URLSessionDataTask?{
        
        if let placeholder = placeholderImage {
            image = placeholder
        }else{
            // Nulling out the image to avoid showing images in previous cells when using with table view cells
            image = nil;
        }
        
        var key = ""
        if let cachedKey = cachedKey {
            key = cachedKey
        } else {
            key = urlString
        }
        
        if let image = imageCache.object(forKey: NSString(string: key)) {
            self.image = image
            return nil
        }
        
        guard let url = URL(string: urlString) else{
            return nil
        }
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let err = error {
                print("Error has ocurred while downloading the image. Error: \(err.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data){
                        imageCache.setObject(downloadedImage, forKey: NSString(string: key))
                        self.image = downloadedImage
                    }
                }
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
