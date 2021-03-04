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
    
    var viewModel: LoginViewModel!
    private var navigator: DefaultLoginNavigator?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = LoginViewModel.Input(username: usernameTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(), loginTrigger: logginButton.rx.tap.asDriver(), signUpTrigger: signUpButton.rx.tap.asDriver())
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        navigator = DefaultLoginNavigator(navigationController: self.navigationController ?? UINavigationController(), storyBoard: storyboard)
        viewModel = LoginViewModel(navigator: navigator!)
        let output = viewModel.transform(input: input)
        output.login.drive()
            .disposed(by: bag)
        output.signUp.drive()
            .disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            self.navigator = DefaultLoginNavigator(navigationController: self.navigationController ?? UINavigationController(), storyBoard: storyboard)
            self.navigator?.toHomeView()
        }
    }
    
    // MARK: -action
    @IBAction func signUp(_ sender: Any) {
    }
    @IBAction func login(_ sender: Any) {
    }
}
