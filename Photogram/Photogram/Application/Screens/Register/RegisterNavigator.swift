//
//  RegisterNavigator.swift
//  Photogram
//
//  Created by LTT on 04/03/2021.
//

import Foundation
import UIKit
import Firebase

protocol RegisterNavigator {
    func toLoggin()
    func displayAlert(confirmPasswordError: String, error: NSError?)
}

class DefaultRegisterNavigator: RegisterNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLoggin() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func displayAlert(confirmPasswordError: String, error: NSError?) {
        let views = navigationController.viewControllers
        let registerView: RegisterViewController = views.last as? RegisterViewController ?? RegisterViewController()
        if confirmPasswordError == "" {
            switch AuthErrorCode(rawValue: error?.code ?? 0) {
            case .missingEmail:
                registerView.errorOfEmailLabel.text = error?.localizedDescription
            case .invalidEmail:
                registerView.errorOfEmailLabel.text = error?.localizedDescription
            case .wrongPassword:
                registerView.errorOfPasswordLabel.text = error?.localizedDescription
            case .weakPassword:
                registerView.errorOfPasswordLabel.text = error?.localizedDescription
            default:
                let alertHelper = AlertHelper(error: error?.localizedDescription ?? "", title: "Register", navigationController: navigationController)
                alertHelper.presentAlert()
            }
        } else {
            registerView.errorOfConfirmPasswordLabel.text = confirmPasswordError
        }
    }
}
