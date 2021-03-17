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
    func presentAlert(error: String)
}

class DefaultRegisterNavigator: RegisterNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLoggin() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func presentAlert(error: String) {
        let alertController: UIAlertController = UIAlertController(title: "Can't create a new account!", message: error, preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
