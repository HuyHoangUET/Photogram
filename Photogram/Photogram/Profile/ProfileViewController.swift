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
    
    var viewModel: ProfileViewmodel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ProfileViewmodel.Input(logoutTrigger: logoutButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {
            print("viewmodel nil")
            return}
        let output = viewModel.transform(input: input)
        output.logout.drive()
            .disposed(by: bag)
    }
}
