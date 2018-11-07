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
    
    var targetSource: CollectionViewType = .library {
        didSet {
            vm.viewType = targetSource
            navigationItem.title = targetSource.rawValue
        }
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var imageCollectView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectView.delegate = self
        imageCollectView.dataSource = self
        
        vm.delegate = self
        vm.getImageList()
        collectionViewLayoutSetup ()
        
        updateDoneButtonTitle()
    }
    
    func collectionViewLayoutSetup () {
        let layout = imageCollectView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = self.view.frame.width / 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    func updateDoneButtonTitle() {
        doneButton.title = "Done(\(ImageDataModel.resultImages.count))"
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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
        cell.delegate = self
        return cell
    }
}

extension PickerViewController: CollectionViewModelDelegate {
    func reloadImageTable() {
        imageCollectView.reloadData()
    }
}

extension PickerViewController: PickerCollectionViewCellDelegate {
    func imageSelected(_ image: ImageDataModel) {
        ImageDataModel.resultImages.append(image)
        updateDoneButtonTitle()
    }
    
    func imageUnselected(_ image: ImageDataModel) {
        ImageDataModel.resultImages.removeAll { $0.url == image.url }
        updateDoneButtonTitle()
    }
}
