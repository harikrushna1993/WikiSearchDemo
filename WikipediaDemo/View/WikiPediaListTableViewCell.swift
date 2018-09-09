//
//  WikiPediaListTableViewCell.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit

class WikiPediaListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageviewItem: UIImageView!
    @IBOutlet weak var constraintWidthItemImage: NSLayoutConstraint!
    
    let imageCache = NSCache<NSString, UIImage>()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData( data: SearchWikiDataModel) {
        
        labelTitle.text = data.titleText
        labelDesc.text = data.descriptionText
        constraintWidthItemImage.constant = 40
        if data.thumbanil.count == 0 {
            constraintWidthItemImage.constant = 0
            return
        }
        imageviewItem.image = UIImage()
        if let cachedImage = imageCache.object(forKey: data.thumbanil as NSString ) {
            self.imageviewItem.image = cachedImage
        } else {
            NetworkWrapper.downloadImage(urlString: data.thumbanil, sucess: { (image) in
                self.imageCache.setObject(image, forKey: data.thumbanil as NSString)
                self.imageviewItem.image = image
            }, failure: { (success) in
            })
        }
    }

}
