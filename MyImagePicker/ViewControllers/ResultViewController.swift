//
//  ViewController.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/4/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let vm = CollectionViewModel(CollectionViewType.library)
    
    @IBOutlet weak var resultImageCollectionView: UICollectionView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var addButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resultImageCollectionView.delegate = self
        resultImageCollectionView.dataSource = self
        
        vm.delegate = self
        vm.getImageList()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Images", message: "Please choose a image source", preferredStyle: .actionSheet)
        
        let first = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            
        }
        alertController.addAction(first)
        
        let second = UIAlertAction(title: "Unsplash", style: .default) { (action) in
            
        }
        alertController.addAction(second)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.getNumSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getNumRows(of: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultImageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ResultCollectionViewCell
        cell.image = vm.getData(at: indexPath.row)
        return cell
    }
}

extension ResultViewController: CollectionViewModelDelegate {
    func reloadImageTable() {
        resultImageCollectionView.reloadData()
    }
}
