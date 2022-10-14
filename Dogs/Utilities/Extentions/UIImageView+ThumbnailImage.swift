//
//  UIImageView+ThumbnailImage.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/13/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString,UIImage>()

extension UIImageView{
    
    @discardableResult
    func loadImageFrom(_ urlString:String, _ placeholderImage: UIImage? = nil) -> URLSessionDataTask?{
        
        image = nil;
        
        if let image = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = image
            return nil
        }
        
        guard let url = URL(string: urlString) else{
            return nil
        }
        
        if let placeholder = placeholderImage {
            image = placeholder
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let err = error {
                print("Error has ocurred while downloading the image. Error: \(err.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data){
                        imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                        self.image = downloadedImage
                    }
                }
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
