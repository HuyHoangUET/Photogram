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
    }
}
