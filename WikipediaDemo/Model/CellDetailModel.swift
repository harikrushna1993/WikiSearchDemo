//
//  SearchWikiDataModel.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit

class SearchWikiDataModel: NSObject {
    
    var titleText = ""
    var descriptionText = ""
    var thumbanil = ""
    var pageId = ""
    
    override init() {
        super.init()
    }
    
    init(title: String, desc: String, img: String, pgeId: String) {
         super.init()
        titleText = title
        descriptionText = desc
        thumbanil = img
        pageId = pgeId
        cacheImage(imgUrl: thumbanil)
    }

    func cacheImage(imgUrl:String) {
        UIImageView().loadImageUsingCache(withUrl: imgUrl)
    }
    
}
