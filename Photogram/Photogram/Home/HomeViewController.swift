//
//  HomeViewController.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import UIKit
import Firebase
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: outlet
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var viewModel: HomeViewmodel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = HomeViewmodel.Input(logoutTrigger: logoutButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {return}
        let output = viewModel.transform(input: input)
        output.logout.drive()
            .disposed(by: bag)
    }
}
