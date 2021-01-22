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

class LoginViewController: UIViewController {
    let viewModel = LoginViewModel()
    // MARK: -outlet
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -action
    @IBAction func didEndEditUsername(_ sender: Any) {
    }
    @IBAction func didEndEditPassword(_ sender: Any) {
    }
    @IBAction func login(_ sender: Any) {
        viewModel.user.account.username = usernameText.text ?? ""
        viewModel.user.account.password = passwordText.text ?? ""
        
        Auth.auth().signIn(withEmail: viewModel.user.account.username,
                           password: viewModel.user.account.password) { (authResult, error) in
            if let error = error as NSError? {
                let alertController:UIAlertController = UIAlertController(title: "Login failed!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let homeView = HomeViewController()
                self.navigationController?.pushViewController(homeView, animated: true)
                print("Login success.")
            }
        }
        
//        viewModel.requestLogin()
//            .subscribe(onNext: { error in
//                if error == "" {
//                    print("Login Success.")
//                } else {
//                    let alertController:UIAlertController = UIAlertController(title: "Login failed!", message: error, preferredStyle: UIAlertController.Style.alert)
//                    let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
//                    alertController.addAction(alertAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            })
//            .disposed(by: DisposeBag())
    }
}
