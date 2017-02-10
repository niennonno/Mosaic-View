//
//  laLaViewController.swift
//  Mosaic View
//
//  Created by Aditya Vikram Godawat on 10/02/17.
//
//

import UIKit

class laLaViewController: UIViewController {

    var anImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        let anImageView = UIImageView(frame: view.frame)
        view.addSubview(anImageView)
        anImageView.image = anImage
        anImageView.contentMode = .scaleAspectFit
    
    }
}
