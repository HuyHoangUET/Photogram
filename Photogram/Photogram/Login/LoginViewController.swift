//
//  LoginViewController.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import UIKit
import Firebase

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
    @IBAction func signUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let registerView = (storyboard.instantiateViewController(withIdentifier: "RegisterViewController")) as! RegisterViewController
        self.navigationController?.pushViewController(registerView, animated: true)
    }
    @IBAction func login(_ sender: Any) {
        viewModel.user.account.username = usernameText.text ?? ""
        viewModel.user.account.password = passwordText.text ?? ""
        
        viewModel.requestLogin(complettion: { done in
            if done {
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.present(homeView, animated: true, completion: nil)
            } else {
                let alertController:UIAlertController = UIAlertController(title: "Login failed!", message: self.viewModel.errorMessage, preferredStyle: UIAlertController.Style.alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}
