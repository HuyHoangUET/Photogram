//
//  LoginViewController.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import UIKit

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
        viewModel.requestLogin()
    }
}
