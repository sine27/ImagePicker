//
//  ViewController.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/4/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultImageCollectionView: UICollectionView!
    @IBOutlet weak var actionView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resultImageCollectionView.delegate = self
        resultImageCollectionView.dataSource = self
    }

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultImageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ResultCollectionViewCell
        cell.backgroundColor = UIColor.black
        return cell
    }
}

