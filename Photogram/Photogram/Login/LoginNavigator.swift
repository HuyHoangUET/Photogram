//
//  LoginNavigator.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol LoginNavigator {
    func toRegisterView()
    func toHomeView()
}

class DefaultLoginNavigator: LoginNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toHomeView() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController.setViewControllers([homeView], animated: true)
    }
    
    func toRegisterView() {
        let storyboard2 = UIStoryboard(name: "Register", bundle: nil)
        let registerView = storyboard2.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController.pushViewController(registerView, animated: true)
    }
}
