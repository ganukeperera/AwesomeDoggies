//
//  UIImageView+ThumbnailImage.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/13/22.
//

import Foundation
import UIKit

extension UIImageView{
    
    @discardableResult
    func loadImageFrom(_ urlString:String, _ placeholderImage: UIImage? = nil) -> URLSessionDataTask?{
        
        if let placeholder = placeholderImage {
            image = placeholder
        }else{
            // Nulling out the image to avoid showing previous image when re-using the table view cell
            image = nil;
        }
        
        guard let url = URL(string: urlString) else{
            return nil
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print("Error has ocurred while downloading the image. Error: \(err.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data){
                        self.image = downloadedImage
                    }
                }
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
