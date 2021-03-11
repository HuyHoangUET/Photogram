//
//  RegisterViewController.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    // MARK: -outlet
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var errorOfEmailLabel: UILabel!
    @IBOutlet weak var errorOfPasswordLabel: UILabel!
    @IBOutlet weak var errorOfConfirmPasswordLabel: UILabel!
    
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -action
    @IBAction func register(_ sender: Any) {
        if passwordText.text == confirmPasswordText.text {
            viewModel.requestRegister(email: emailText.text ?? "", password: passwordText.text ?? "", completetion: {error in
                if error == NSError() {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .missingEmail:
                        self.errorOfEmailLabel.text = error.localizedDescription
                    case .emailAlreadyInUse:
                        self.errorOfEmailLabel.text = error.localizedDescription
                    case .invalidEmail:
                        self.errorOfEmailLabel.text = error.localizedDescription
                    case .weakPassword:
                        self.errorOfPasswordLabel.text = error.localizedDescription
                    default:
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })
        } else {
            errorOfConfirmPasswordLabel.text = "Password confirmation doesn't match Password."
        }
    }
}
