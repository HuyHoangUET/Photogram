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
}

class DefaultRegisterNavigator: RegisterNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLoggin() {
        navigationController.popToRootViewController(animated: true)
    }
}
