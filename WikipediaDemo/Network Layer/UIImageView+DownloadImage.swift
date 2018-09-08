//
//  UIImageView+DownloadImage.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        
        guard let urrl = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString ) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: urrl, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}






