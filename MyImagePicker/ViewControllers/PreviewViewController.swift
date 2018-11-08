//
//  PreviewViewController.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit
import AlamofireImage

@objc protocol ImageCellDelegate: class {
    @objc func toPreview(image: ImageDataModel)
}

class PreviewViewController: UIViewController {
    
    var vm: PreviewViewModel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkButton: CheckBox!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 6.0
        
        if let data = vm.getImageUrl(), let url = data.url {
            imageView.af_setImage(withURL: url)
            checkButton.isChecked = ImageDataModel.resultImages.contains(where: { $0.url == url })
        }
    }
    
    @IBAction func checkButtonTapped(_ sender: CheckBox) {
        if let image = vm.imageData {
            if sender.isChecked {
                 ImageDataModel.resultImages.removeAll { $0.url == image.url }
            } else {
                ImageDataModel.resultImages.append(image)
            }
        }
    }
    
    @IBAction func backToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
