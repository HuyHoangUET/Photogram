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

class HomeViewController: BaseViewController {
    // MARK: outlet
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var viewModel: HomeViewmodel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
    }
}
