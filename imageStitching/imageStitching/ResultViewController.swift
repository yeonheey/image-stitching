//
//  ResultViewController.swift
//  imageStitching
//
//  Created by 정연희 on 2021/07/31.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        okButton.layer.cornerRadius = 5
        okButton.addTarget(self, action: #selector(okButtonTouchUp), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc func okButtonTouchUp() {
        self.dismiss(animated: true)
    }
}
