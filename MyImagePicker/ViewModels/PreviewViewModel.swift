//
//  PreviewViewModel.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class PreviewViewModel: NSObject {
    
    var imageData: ImageDataModel?
    
    init(imageData: ImageDataModel?) {
        self.imageData = imageData
    }

    func getImageUrl() -> ImageDataModel? {
        return imageData
    }
}
