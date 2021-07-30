//
//  ViewController.swift
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: properties
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    } ()
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Actions
    @IBAction func touchUpPhotoPickerButton(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true)
    }
    
    @IBAction func touchUpConvertButton(_ sender: UIButton) {
        if let image = imageView.image {
            let edgeImage = OpenCVWrapper.detectEdge(image)
            
            self.imageView.image = edgeImage
        }
    }
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true)
    }
}

