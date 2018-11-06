//
//  ResultCollectionViewCell.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/4/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit
import AlamofireImage

class ResultCollectionViewCell: UICollectionViewCell {
    
    var image: ImageDataModel! {
        didSet {
            if image != nil {
                setup(data: image)
            }
        }
    }
    
    @IBOutlet weak var resultImage: UIImageView!
    
    override func prepareForReuse() {
        resultImage.image = nil
    }
    
    override func awakeFromNib() {
        // Set up cell UI
    }
    
    func setup(data: ImageDataModel) {
        print(#function)
        resultImage.af_setImage(withURL: URL(string: data.url_regular) ?? URL(string: "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png")!)
    }
}
