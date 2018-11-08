//
//  Helper.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit
import Photos

extension PHAsset {
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                if let contentEditingInput = contentEditingInput {
                    completionHandler(contentEditingInput.fullSizeImageURL as URL?)
                } else {
                    Log.error(funcName: #function, data: "contentEditingInput = nil")
                }
            })
        }
    }

    func getImageData(asset: PHAsset) -> Data? {
        var imageData: Data?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            imageData = data
        }
        return imageData
    }
}


