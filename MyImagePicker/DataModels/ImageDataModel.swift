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
    
    init(dict: NSDictionary) {
        if let urls = dict["urls"] as? NSDictionary {
            print(#function)
            if let urlstring = urls["regular"] as? String {
                self.url = URL(string: urlstring)
            }
        }
    }
    
    init(url: URL) {
        self.url = url
    }
    
    static var resultImages: [ImageDataModel] = [] {
        didSet {
            Log.message(funcName: #function, data: resultImages)
        }
    }
}
