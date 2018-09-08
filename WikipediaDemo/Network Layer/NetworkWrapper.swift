//
//  NetworkWrapper.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit

struct ApiConstant {
    static let BASEURL = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description"
}

class NetworkWrapper: NSObject {
    
    class func makeApiRequest(url:String,sucess: @escaping(( _ response: [String: Any]) -> Void),failure:  @escaping(( _ response: Bool) -> Void)) {
    
        guard let urrl = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: urrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(120))
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        if data != nil {
                            let decoded = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(decoded)
                            sucess(decoded as! [String: Any])
                        }
                    } catch {
                        failure(true)
                        print(error.localizedDescription)
                    }
                } else {
                    print(error?.localizedDescription as Any)
                    failure(true)
                }
            }
        }
        task.resume()
}

  class  func downloadImage(urlString : String,sucess: @escaping(( _ response: UIImage) -> Void),failure:  @escaping(( _ response: Bool) -> Void)) {
    
    guard let urrl = URL(string: urlString) else {
        print("Error: cannot create URL")
        return
    }
            
        URLSession.shared.dataTask(with: urrl, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                failure(false)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    sucess(image)
                }
            }
            
        }).resume()
    }
}






