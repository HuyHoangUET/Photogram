//
//  RegisterNavigator.swift
//  Photogram
//
//  Created by LTT on 04/03/2021.
//

import Foundation
import UIKit

protocol RegisterNavigator {
    func toLoggin()
    func presentAlert(error: NSError)
    func presentConfirmPasswordAlert()
}

class DefaultRegisterNavigator: RegisterNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLoggin() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func presentAlert(error: NSError) {
        let alertController: UIAlertController = UIAlertController(title: "Can't create a new account!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func presentConfirmPasswordAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Can't create a new account!", message: "Password confimation doesn't match password!", preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
