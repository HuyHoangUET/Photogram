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
    
    private var viewModel: HomeViewmodel!
    private var navigator: DefaultHomeNavigator?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = HomeViewmodel.Input(logoutTrigger: logoutButton.rx.tap.asDriver())
        navigator = DefaultHomeNavigator(navigationController: self.navigationController ?? UINavigationController())
        viewModel = HomeViewmodel(navigator: navigator!)
        let output = viewModel.transform(input: input)
        output.logout.drive()
            .disposed(by: bag)
    }
    
    // MARK: -action
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("error")
        }
    }
}
