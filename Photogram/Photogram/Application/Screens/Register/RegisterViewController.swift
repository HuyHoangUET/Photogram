//
//  RegisterViewController.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import UIKit
import Firebase
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    // MARK: outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorOfEmailLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    @IBOutlet weak var errorOfConfirmPasswordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel: RegisterViewModel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = RegisterViewModel.Input(username: emailTextField.rx.text.orEmpty.asDriver(),
                                            password: passwordTextField.rx.text.orEmpty.asDriver(),
                                            confirmPassword: confirmPasswordTextField.rx.text.orEmpty.asDriver(),
                                            registerTrigger: registerButton.rx.tap.asDriver())
        guard let viewModel = viewModel else {
            print("viewModel nil")
            return
        }
        let output = viewModel.transform(input: input)
        output.signUp.drive()
            .disposed(by: bag)
        output.error.drive(errorBinding)
            .disposed(by: bag)
        output.confirmPasswordError
            .drive(onNext: {error in
                self.errorOfConfirmPasswordLabel.text = error
            })
            .disposed(by: bag)
    }
    
    var errorBinding: Binder<NSError> {
        return Binder(self, binding: {registerView, error in
            switch AuthErrorCode(rawValue: error.code) {
            case .missingEmail:
                registerView.errorOfEmailLabel.text = error.localizedDescription
            case .invalidEmail:
                registerView.errorOfEmailLabel.text = error.localizedDescription
            case .wrongPassword:
                registerView.errorOfPasswordLabel.text = error.localizedDescription
            case .weakPassword:
                registerView.errorOfPasswordLabel.text = error.localizedDescription
            default:
                AlertHelper.shared.presentAlert(title: "Register", error: error, view: self)
            }
        })
    }
}
