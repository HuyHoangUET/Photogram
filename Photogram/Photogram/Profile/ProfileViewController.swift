//
//  ProfileViewController.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit
import Firebase
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    // MARK: -outlet
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var numberOfFollowersLabel: UILabel!
    @IBOutlet weak var numberOfFollwingLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var photoCollectonView: UICollectionView!
    
    var viewModel: ProfileViewmodel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        designUploadButton()
    }
    
    func bindViewModel() {
        let input = ProfileViewmodel.Input(logoutTrigger: logoutButton.rx.tap.asDriver(), uploadTrigger: uploadButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {return}
        let output = viewModel.transform(input: input)
        output.logout.drive()
            .disposed(by: bag)
        output.toUploadView.drive()
            .disposed(by: bag)
    }
    
    func designUploadButton() {
        uploadButton.layer.cornerRadius = 5
        uploadButton.layer.masksToBounds = true
    }
}
