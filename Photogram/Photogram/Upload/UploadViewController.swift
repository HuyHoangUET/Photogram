//
//  UploadViewController.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: -outlet
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -action
    @IBAction func upload(_ sender: Any) {
        let picker  = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false

        present(picker, animated: true, completion: nil)
    }
}
