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
    private let resultViewController = ResultViewController()
    
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
        if imageSet.count == 2 {
            resultViewController.imageSet = self.imageSet
            present(resultViewController, animated: true)
        } else {
            let alert = UIAlertController(title: "", message: "2 개의 이미지를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
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
