//
//  ImagingViewController.swift
//  Mosaic View
//
//  Created by Aditya Vikram Godawat on 10/02/17.
//
//

import UIKit
import MobileCoreServices

class ImagingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let aBtn = UIButton(frame: CGRect(origin: view.center, size: CGSize(width: 45, height: 45)))
        aBtn.setTitle("Yeelo!", for: .normal)
        view.addSubview(aBtn)
        aBtn.setTitleColor(.blue, for: .normal)
        aBtn.addTarget(self, action: #selector(Image), for: .touchUpInside)
        
    }
    
    
    func Image() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.mediaTypes = [kUTTypeMovie as String]
//            imagePicker.mediaTypes = [kUTTypeAudio as String]
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
            
            //            newMedia = false
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
    }
}
