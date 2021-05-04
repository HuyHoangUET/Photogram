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
    func toLogginView()
}

class DefaultRegisterNavigator: RegisterNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLogginView() {
        navigationController.popToRootViewController(animated: true)
    }
}
