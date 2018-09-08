//
//  SearchWikiApiManager.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit

class SearchWikiViewModel: NSObject {
  
    func searchWikipediaAPI(searchString: String,sucess: @escaping(( _ response: [SearchWikiDataModel]) -> Void) ) {
        
        let apiUrl = ApiConstant.BASEURL + "&gpssearch=" + searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&gpslimit=20"
        
        NetworkWrapper.makeApiRequest(url: apiUrl, sucess: { (searchData) in
            sucess(self.parseWikiDataResults(searchData))
        }) { _ in
        }
    }
    
     func parseWikiDataResults(_ results: [String: Any]) -> [SearchWikiDataModel] {
        var arrWikiData = [SearchWikiDataModel]()
        if let queryDict = results["query"] as? [String :Any] {
            let pagesArray = queryDict["pages"] as! [[String :Any]]
            for pageDict in pagesArray {
                let title = pageDict["title"] as? String ?? ""
                var description = ""
                if let terms = pageDict["terms"] as? [String: Any],
                    let descriptionArray = terms["description"] as? [String] {
                    description = descriptionArray[0] 
                }
                var imageSource = ""
                if let thumbanil = pageDict["thumbnail"] as? [String: Any] {
                    imageSource = thumbanil["source"] as? String ?? ""
                }
                let pageId = String.init(pageDict["pageid"] as! Int)
                if title.trimmingCharacters(in: CharacterSet.whitespaces).count > 0 {
                    let wikiData = SearchWikiDataModel(title: title, desc: description, img: imageSource, pgeId: pageId)
                    arrWikiData.append(wikiData)
                }               
            }
        }
        return arrWikiData
    }
    
}
