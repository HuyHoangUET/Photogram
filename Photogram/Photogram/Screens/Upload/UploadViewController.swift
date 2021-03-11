//
//  UploadViewController.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UploadViewController: UIViewController,
                            UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var viewModel: UploadViewModel?
    private let bag = DisposeBag()
    // MARK: outlet
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = UploadViewModel.Input(chooseTriger: chooseButton.rx.tap.asDriver(),
                                          uploadTrigger: uploadButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {return}
        viewModel.picker.delegate = self
        let output = viewModel.transform(input: input)
        output.choosePhoto.drive()
            .disposed(by: bag)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        self.photoImage.image = image
        self.chooseButton.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
}
