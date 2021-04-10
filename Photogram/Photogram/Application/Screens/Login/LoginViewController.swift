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

class LoginViewController: BaseViewController {
    // MARK: outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorOfUsernameLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    @IBOutlet weak var logginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(username: usernameTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(),
                                         loginTrigger: logginButton.rx.tap.asDriver(),
                                         signUpTrigger: signUpButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {return}
        
        let output = viewModel.transform(input: input)
        
        output.login
            .drive(onNext: {_ in
                self.errorOfUsernameLabel.text?.removeAll()
                self.errorOfPasswordLabel.text?.removeAll()
        })
            .disposed(by: bag)
        output.signUp.drive()
            .disposed(by: bag)
        output.error
            .drive(errorBinding)
            .disposed(by: bag)
    }
    
    var errorBinding: Binder<NSError> {
        return Binder(self, binding: {(loginView, error) in
            switch AuthErrorCode(rawValue: error.code) {
            case .missingEmail:
                loginView.errorOfUsernameLabel.text = error.localizedDescription
            case .invalidEmail:
                loginView.errorOfUsernameLabel.text = error.localizedDescription
            case .wrongPassword:
                loginView.errorOfPasswordLabel.text = error.localizedDescription
            case .weakPassword:
                loginView.errorOfPasswordLabel.text = error.localizedDescription
            default:
                AlertHelper.shared.presentAlert(title: "Login", error: error, view: self)
            }
        })
    }
}
