//
//  ResultViewModel.swift
//  MyImagePicker
//
//  Created by Shayin Feng on 11/4/18.
//  Copyright © 2018 Shayin Feng. All rights reserved.
//

import UIKit
import Alamofire
import Photos

enum CollectionViewType {
    case result
    case library
    case unsplash
}

@objc protocol CollectionViewModelDelegate: class {
    @objc func reloadImageTable()
    
    // Optional functions
    @objc optional func presentAltertMessage(message: String)
    @objc optional func reloadImageTable(scrollToTop: Bool)
}

class CollectionViewModel: NSObject {
    
    var delegate: CollectionViewModelDelegate?
    var viewType = CollectionViewType.result
    
    // MARK: - Data Variables
    
    /** Reload Table when data updated
     *  imageList is always set to [] to ensure imageList.length != nil
     */
    var imageList: [ImageDataModel] = [] {
        didSet {
            delegate?.reloadImageTable()
        }
    }
    
    var selectedImage: ImageDataModel?
    
    init(_ type: CollectionViewType = .result) {
        self.viewType = type
    }
    
    // MARK: - Functions
    
    func getNumSections() -> Int {
        return 1
    }
    
    func getNumRows(of section: Int) -> Int {
        return section == 0 ? imageList.count:0
    }

    func getData(at row: Int) -> ImageDataModel? {
        return row < imageList.count ? imageList[row]:nil
    }
    
    // MARK: - API
    
    /** Parameters
     *  page        : Page number to retrieve. (Optional; default: 1)
     *  per_page    : Number of items per page. (Optional; default: 10)
     *  order_by    : How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
     */
    func getImageList(page: Int = 1) {
        
        // fetch photos from result
        if viewType == .result {
            
        }
        
        // fetch photos from local library
        if viewType == .library {
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    let fetchOptions = PHFetchOptions()
                    let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    print("Found \(allPhotos.count) assets")
                    print(allPhotos.object(at: 0))
                case .denied, .restricted:
                    print("Not allowed")
                case .notDetermined:
                    // Should not see this when requesting
                    print("Not determined yet")
                }
            }
        }
        
        // fetch photos from unsplash
        if viewType == .unsplash {
            var parameters: Parameters = [:]
            parameters.updateValue(page, forKey: "page")
            
            APIHandler.fetchData(urlString: APIHandler.APIScheme.getPhotos, parameters: parameters, success: { (response) in
                if let dictArr = response as? [NSDictionary] {
                    Log.message(funcName: #function, data: dictArr[0])
                    var list: [ImageDataModel] = []
                    for dict in dictArr {
                        list.append(ImageDataModel(dict: dict))
                    }
                    self.imageList = list
                }
            }) { (error) in
                Log.error(funcName: #function, data: error ?? "Error")
            }
        }
    }
}
