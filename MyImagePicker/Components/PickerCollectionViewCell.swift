//
//  SelectCollectionViewCell.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

@objc protocol PickerCollectionViewCellDelegate: class {
    @objc func imageSelected(_ image: ImageDataModel)
    @objc func imageUnselected(_ image: ImageDataModel)
}

class PickerCollectionViewCell: UICollectionViewCell {
    var image: ImageDataModel! {
        didSet {
            if image != nil {
                setup(data: image)
            }
        }
    }
    
    var previewDelegate: ImageCellDelegate?
    
    var delegate: PickerCollectionViewCellDelegate?
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var checkButton: CheckBox!
    
    override func prepareForReuse() {
        resultImage.image = nil
        checkButton.isChecked = false
    }
    
    override func awakeFromNib() {
        // Set up cell UI
        resultImage.isUserInteractionEnabled = true
        resultImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPreview(sender: ))))
    }
    
    @IBAction func checkButtonTapped(_ sender: CheckBox) {
        if sender.isChecked {
            delegate?.imageUnselected(image)
        } else {
            delegate?.imageSelected(image)
        }
    }
    
    func setup(data: ImageDataModel) {
        if let url = data.url {
            resultImage.af_setImage(withURL: url)
        }
        
        if let imagedata = data.data {
            resultImage.image = UIImage(data: imagedata)
        }
        checkButton.isChecked = ImageDataModel.resultImages.contains(where: { $0.url == data.url })
    }
    
    @objc func toPreview(sender: UITapGestureRecognizer) {
        previewDelegate?.toPreview(image: image)
    }
}
