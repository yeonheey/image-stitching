//
//  ViewController.swift
//  imageStitching
//
//  Created by 정연희 on 2021/07/30.
//

import UIKit
import SnapKit
import Photos
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    // MARK: properties
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    let stitchedResultViewController = StitchedImageViewController()
    
    // MARK: - Actions
    @IBAction func touchUpPhotoPickerButton(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 2
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    @IBAction func touchUpConvertButton(_ sender: UIButton) {
        if leftImageView.image == nil || rightImageView.image == nil {
            let alert = UIAlertController(title: "",
                                          message: "2 개의 이미지를 선택해주세요.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인",
                                          style: .default))
            present(alert, animated: true)
        } else {
            guard let leftImage = self.leftImageView.image else {
                return
            }
            guard let rightImage = self.rightImageView.image else {
                return
            }
            
            let resultImage = OpenCVWrapper.stitchTwoImages(
                leftImage,
                rightImage: rightImage)
            
            self.stitchedResultViewController.resultImage = resultImage
            
            self.present(self.stitchedResultViewController, animated: true)
        }
    }
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertButton.layer.cornerRadius = 5
        convertButton.isEnabled = false
        convertButton.backgroundColor = .gray
        
        imagePickerButton.layer.cornerRadius = 5
    }
    
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        if results.count > 1 {
            convertButton.isEnabled = true
            convertButton.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { imageObject, error in
                        if error == nil {
                            if let image = imageObject as? UIImage {
                                
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
