//
//  ViewController.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/4/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let vm = CollectionViewModel(CollectionViewType.result)
    var targetSource: CollectionViewType = .library
    var selectedImage: ImageDataModel?
    
    @IBOutlet weak var resultImageCollectionView: UICollectionView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resultImageCollectionView.delegate = self
        resultImageCollectionView.dataSource = self
        vm.delegate = self
        collectionViewLayoutSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vm.getImageList() 
        setTitle(with: ImageDataModel.resultImages.count)
        resultImageCollectionView.reloadData()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Images From", message: nil, preferredStyle: .actionSheet)
 
        let first = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.targetSource = .library
            self.performSegue(withIdentifier: "toPicker", sender: self)
        }
        first.setValue(UIColor(red: 80/255, green: 190/255, blue: 175/255, alpha: 1.0), forKey: "titleTextColor")
        alertController.addAction(first)
        
        let second = UIAlertAction(title: "Unsplash", style: .default) { (action) in
            self.targetSource = .unsplash
            self.performSegue(withIdentifier: "toPicker", sender: self)
        }
        second.setValue(UIColor(red: 80/255, green: 190/255, blue: 175/255, alpha: 1.0), forKey: "titleTextColor")
        alertController.addAction(second)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        cancelActionButton.setValue(UIColor.lightGray, forKey: "titleTextColor")
        alertController.addAction(cancelActionButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setTitle(with imageCount: Int) {
        titleLabel.text = "\(imageCount) \(imageCount > 1 ? "Images":"Image") Selected"
    }
    
    func collectionViewLayoutSetup () {
        let layout = resultImageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = self.view.frame.width / 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicker" {
            if let vc = segue.destination as? PickerViewController {
                vc.targetSource = self.targetSource
            }
        }
        
        if segue.identifier == "toPreview" {
            if let vc = segue.destination as? PreviewViewController {
                vc.vm = PreviewViewModel(imageData: selectedImage)
            }
        }
    }

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.getNumSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = vm.getNumRows(of: section)
        if section == 0 {
            setTitle(with: count)
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultImageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ResultCollectionViewCell
        cell.image = vm.getData(at: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension ResultViewController: CollectionViewModelDelegate {
    func reloadImageTable() {
        resultImageCollectionView.reloadData()
    }
}

extension ResultViewController: ImageCellDelegate {
    func toPreview(image: ImageDataModel) {
        selectedImage = image
        performSegue(withIdentifier: "toPreview", sender: self)
    }
}
