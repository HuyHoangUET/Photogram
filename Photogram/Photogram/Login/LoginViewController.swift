//
//  LoginViewController.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import UIKit
import Firebase
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    // MARK: -outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorOfUsernameLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    @IBOutlet weak var logginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: LoginViewModel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(username: usernameTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(), loginTrigger: logginButton.rx.tap.asDriver(), signUpTrigger: signUpButton.rx.tap.asDriver())
        guard viewModel != nil else {return}
        let output = viewModel!.transform(input: input)
        output.login.drive()
            .disposed(by: bag)
        output.signUp.drive()
            .disposed(by: bag)
    }
}
