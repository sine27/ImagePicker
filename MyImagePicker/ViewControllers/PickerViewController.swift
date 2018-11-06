//
//  PickerViewController.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/5/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit
import Photos

class PickerViewController: UIViewController {
    
    let vm = CollectionViewModel()
    
    @IBOutlet weak var imageCollectView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension PickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.getNumSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getNumRows(of: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PickerCollectionViewCell
        cell.image = vm.getData(at: indexPath.row)
        return cell
    }
}
