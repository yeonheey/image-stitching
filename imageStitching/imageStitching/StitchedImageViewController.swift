//
//  StitchedImageViewController.swift
//  imageStitching
//
//  Created by 정연희 on 2021/08/09.
//

import UIKit

class StitchedImageViewController: UIViewController {
    @IBOutlet weak var resultImageView: UIImageView!
    public var resultImage: UIImage?
    
    @IBAction func okEvent(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if resultImage != nil {
            resultImageView.image = resultImage
        }
    }
}
