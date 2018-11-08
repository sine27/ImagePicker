//
//  ImageDataModel.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class ImageDataModel: NSObject {
    
    var url: URL?
    var data: Data?
    
    init(dict: NSDictionary) {
        if let urls = dict["urls"] as? NSDictionary {
            if let urlstring = urls["regular"] as? String {
                self.url = URL(string: urlstring)
            }
        }
    }
    
    init(url: URL) {
        self.url = url
    }
    
    init(data: Data) {
        self.data = data
    }
    
    static var resultImages: [ImageDataModel] = [] {
        didSet {
            Log.message(funcName: #function, data: resultImages)
        }
    }
}
