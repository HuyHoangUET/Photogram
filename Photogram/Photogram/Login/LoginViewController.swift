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
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorOfUsernameLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    
    private let viewModel = LoginViewModel()
    private var navigator: DefaultLoginNavigator?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.handleLogin()
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
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        navigator = DefaultLoginNavigator(navigationController: self.navigationController ?? UINavigationController(), storyBoard: storyboard)
        navigator?.toRegisterView()
    }
    @IBAction func login(_ sender: Any) {
        let userAccount = Account(username: usernameText.text ?? "", password: passwordText.text ?? "")
        let user = User(account: userAccount)
        viewModel.input.user.onNext(user)
        viewModel.output.loginRespone
            .subscribe(onNext: {respone in
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                self.navigator = DefaultLoginNavigator(navigationController: self.navigationController ?? UINavigationController(), storyBoard: storyboard)
                self.navigator?.toHomeView()
            })
            .disposed(by: bag)
        viewModel.output.error
            .subscribe(onNext: {error in
                switch AuthErrorCode(rawValue: error.code) {
                case .missingEmail:
                    self.errorOfUsernameLabel.text = error.localizedDescription
                case .invalidEmail:
                    self.errorOfUsernameLabel.text = error.localizedDescription
                case .wrongPassword:
                    self.errorOfPasswordLabel.text = error.localizedDescription
                default:
                    print(error.localizedDescription)
                }
                let alertController:UIAlertController = UIAlertController(title: "Login failed!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: bag)
    }
}
