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
    
    // MARK: action
    @IBAction func register(_ sender: Any) {
//        if passwordText.text == confirmPasswordText.text {
//            viewModel.requestRegister(email: emailText.text ?? "", password: passwordText.text ?? "", completetion: {error in
//                if error == NSError() {
//                    self.navigationController?.popToRootViewController(animated: true)
//                } else {
//                    switch AuthErrorCode(rawValue: error.code) {
//                    case .missingEmail:
//                        self.errorOfEmailLabel.text = error.localizedDescription
//                    case .emailAlreadyInUse:
//                        self.errorOfEmailLabel.text = error.localizedDescription
//                    case .invalidEmail:
//                        self.errorOfEmailLabel.text = error.localizedDescription
//                    case .weakPassword:
//                        self.errorOfPasswordLabel.text = error.localizedDescription
//                    default:
//                        print("Error: \(error.localizedDescription)")
//                    }
//                }
//            })
//        } else {
//            errorOfConfirmPasswordLabel.text = "Password confirmation doesn't match Password."
//        }
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
    }
}
