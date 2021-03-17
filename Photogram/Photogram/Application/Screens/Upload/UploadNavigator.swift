//
//  UploadNavigator.swift
//  Photogram
//
//  Created by LTT on 11/03/2021.
//

import Foundation
import UIKit

protocol UploadNavigator {
    func presentChoosePhoto(picker: UIImagePickerController)
}

class DefaultUploadNavigator: UploadNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func presentChoosePhoto(picker: UIImagePickerController) {
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        navigationController.present(picker, animated: true, completion: nil)
    }
}
