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
    @IBOutlet weak var errorOfUsernameLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.email)
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(homeView, animated: true, completion: nil)
        }
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
        
        viewModel.requestLogin(complettion: { error in
            if error != NSError() {
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(homeView, animated: true)
            } else {
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
            }
        })
    }
}
