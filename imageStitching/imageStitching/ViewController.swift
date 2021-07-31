//
//  ViewController.swift
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    // MARK: properties
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    private var imageSet: [UIImage] = [UIImage]()
    
    // MARK: - Actions
    @IBAction func touchUpPhotoPickerButton(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 2
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertButton.layer.cornerRadius = 5
        imagePickerButton.layer.cornerRadius = 5
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if results.count > 1 {
            imageSet.removeAll()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { imageObject, error in
                        if error == nil {
                            if let image = imageObject as? UIImage {
                                self.imageSet.append(image)
                                
                                DispatchQueue.main.async {
                                    if results.first == result {
                                        self.leftImageView.image = image
                                    } else {
                                        self.rightImageView.image = image
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
