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
import AVFoundation

class ViewController: UICollectionViewController {
    
    
    var imageArray = [#imageLiteral(resourceName: "ylygw9X.png"), #imageLiteral(resourceName: "14413.jpg"), #imageLiteral(resourceName: "c9e391f96cd27172a71caa7bd694b47d_square-clip-art-clipart-square_800-800.png"), #imageLiteral(resourceName: "a738ceec705d4cb698eb9840818fe4d4.jpg"), "/Users/adityagodawat/Desktop/XCode Projects/PoC/Mosaic View/Mosaic View/van_damme_clip_1.mp4" as String ] as [Any]
    let identifier = "TRMosaicCell"
    var maxheight = CGFloat(0)
    var playerViewController = AVPlayerViewController()
    var player = AVPlayer()
    var rearranged = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let imgManager = PHImageManager.default()
        
        //        show()
        
        //        let requestOptions = PHImageRequestOptions()
        //        requestOptions.isSynchronous = false
        //        requestOptions.deliveryMode = .opportunistic
        //
        //        let fetchOptions = PHFetchOptions()
        //        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        //
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        mosaicLayout.delegate = self
        
        let aBtn = UIBarButtonItem(title: "ReOrder", style: .done, target: self, action: #selector(videoPriority))
        self.navigationItem.rightBarButtonItem = aBtn
        
        //
        //        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
        //
        //            for i in 0..<fetchResult.count {
        //
        //                imgManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: 1200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: { (anImage, error) in
        //                    self.imageArray.append(anImage!)
        //                })
        //
        //            }
        //        } else {
        //            self.collectionView?.reloadData()
        //        }
    }
    
    func videoPriority() {
        
        if !rearranged {
            for i in 0..<imageArray.count {
                
                if imageArray[i] is String {
                    if i%3 == 0 {
                    } else {
                        swap(&imageArray[i], &imageArray[i-(i%3)])
                        self.rearranged = true

                    }
                }
            }
            if rearranged {
                self.collectionView?.reloadData()
            }
            
        } else {
            self.imageArray = [#imageLiteral(resourceName: "ylygw9X.png"), #imageLiteral(resourceName: "14413.jpg"), #imageLiteral(resourceName: "c9e391f96cd27172a71caa7bd694b47d_square-clip-art-clipart-square_800-800.png"), #imageLiteral(resourceName: "a738ceec705d4cb698eb9840818fe4d4.jpg"), "/Users/adityagodawat/Desktop/XCode Projects/PoC/Mosaic View/Mosaic View/van_damme_clip_1.mp4" as String ]
            self.collectionView?.reloadData()
            self.rearranged = false
        }
    }
    
    
    
        func show() {
            let aVC = ImagingViewController()
            self.navigationController?.pushViewController(aVC, animated: true)
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
            var anImage = UIImage()
            let aLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 50, height: 20))
            aCell.addSubview(aLabel)

            if imageArray[indexPath.row] is UIImage {
                anImage = imageArray[indexPath.row] as! UIImage
                aLabel.text = ""

            } else {
                do {
                    let asset = AVURLAsset(url: NSURL(fileURLWithPath: imageArray[indexPath.row] as! String) as URL, options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                    anImage = UIImage(cgImage: cgImage)
                    
                    aLabel.text = "Video"
                } catch let error as NSError {
                    print("Error generating thumbnail: \(error)")
                }
            }
            let anImageView = UIImageView(image: anImage)
            anImageView.frame = aCell.frame
            aCell.clipsToBounds = true
            anImageView.contentMode = .scaleAspectFill
            aCell.backgroundView = anImageView
            aCell.layer.borderWidth = 2
            aCell.layer.borderColor = UIColor.red.cgColor
            
            
            print("Cell \(indexPath.row):", aCell.frame.maxY)
            
            //        collectionView.contentSize.height = maxheight+250
            
            
            return aCell
            
        }
        
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if let anAsset = imageArray[indexPath.row] as? UIImage {
                let aVC = laLaViewController()
                aVC.anImage = anAsset
                self.navigationController?.pushViewController(aVC, animated: true)
            } else {
                let aString = imageArray[indexPath.row] as! String
                player = AVPlayer(url: URL(fileURLWithPath: aString))
                playerViewController.player = player
                self.present(playerViewController, animated: true, completion: {
                    self.playerViewController.player?.play()
                })
            }
            
            
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
