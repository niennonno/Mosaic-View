//
//  ViewController.swift
//  Mosaic View
//
//  Created by Aditya Vikram Godawat on 08/02/17.
//
//

import UIKit
import TRMosaicLayout
import Photos
import AVKit
import MobileCoreServices

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 
    var imageArray = [UIImage]()
    let identifier = "TRMosaicCell"
    var maxheight = CGFloat(0)
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        mosaicLayout.delegate = self
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            
            for i in 0..<fetchResult.count {
          
                imgManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: { (anImage, error) in
                    self.imageArray.append(anImage!)
                })

            }
            
            
        } else {
            self.collectionView?.reloadData()
        }
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
//
//            let imagePicker = UIImagePickerController()
//            
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.mediaTypes = [kUTTypeImage as String]
//            imagePicker.mediaTypes = [kUTTypeMovie as String]
//            imagePicker.mediaTypes = [kUTTypeAudio as String]
//            imagePicker.allowsEditing = false
//            
//            self.present(imagePicker, animated: true, completion: nil)
//            
////            newMedia = false
//        }
        
        
       
        
        
    }
    
    
    
    
    // MARK: - CollectionView Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        let anImageView = UIImageView(image: imageArray[indexPath.row])
        anImageView.frame = aCell.frame
        aCell.clipsToBounds = true
        anImageView.contentMode = .scaleAspectFill
        aCell.backgroundView = anImageView
        aCell.layer.borderWidth = 2
        aCell.layer.borderColor = UIColor.red.cgColor
        
        if maxheight < aCell.frame.maxY {
            maxheight = aCell.frame.maxY
            print(maxheight)
        }
        
        print("Cell \(indexPath.row):", aCell.frame.maxY)
        
//        collectionView.contentSize.height = maxheight+250

        
        return aCell
        
    }
}


extension ViewController: TRMosaicLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? .big : .small
    }
    
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
    
    
}
