//
//  CheckButton.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/6/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    let checkedImage = UIImage(named: "check-button")! as UIImage
    let uncheckedImage = UIImage(named: "uncheck-button")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
