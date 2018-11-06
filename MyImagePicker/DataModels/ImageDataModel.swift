//
//  ImageDataModel.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class ImageDataModel: NSObject {
    
    var url_full = ""
    var url_regular = ""
    var url_small = ""
    var url_thumb = ""
    
    init(dict: NSDictionary) {
        if let urls = dict["urls"] as? NSDictionary {
            print(#function)
            self.url_full = urls["full"] as? String ?? ""
            self.url_regular = urls["regular"] as? String ?? ""
            self.url_small = urls["small"] as? String ?? ""
            self.url_thumb = urls["thumb"] as? String ?? ""
        }
    }

}
