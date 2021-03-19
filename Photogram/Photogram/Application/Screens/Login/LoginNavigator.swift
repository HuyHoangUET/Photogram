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
import Firebase

protocol LoginNavigator {
    func toRegisterView()
    func toHomeView()
    func displayAlert(error: NSError)
}

class DefaultLoginNavigator: LoginNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toHomeView() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeTabbar = storyboard.instantiateViewController(identifier: "HomeTabbarController") as HomeTabbarController
        navigationController.setViewControllers([homeTabbar], animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func toRegisterView() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        guard let registerView = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        let navigator = DefaultRegisterNavigator(navigationController: self.navigationController)
        let respository = Respository()
        let useCase = RegisterUseCase(respository: respository)
        
        registerView.viewModel = RegisterViewModel(useCase: useCase, navigator: navigator)
        navigationController.pushViewController(registerView, animated: true)
    }
    
    func displayAlert(error: NSError) {
        let alertHelper = AlertHelper(error: error.localizedDescription, title: "Login", navigationController: navigationController)
        alertHelper.presentAlert()
        
        let views = navigationController.viewControllers
        let loginView: LoginViewController = views.last as? LoginViewController ?? LoginViewController()
        
        switch AuthErrorCode(rawValue: error.code) {
        case .missingEmail:
            loginView.errorOfUsernameLabel.text = error.localizedDescription
        case .invalidEmail:
            loginView.errorOfUsernameLabel.text = error.localizedDescription
        case .wrongPassword:
            loginView.errorOfPasswordLabel.text = error.localizedDescription
        case .weakPassword:
            loginView.errorOfPasswordLabel.text = error.localizedDescription
        default:
            print(error.localizedDescription)
        }
    }
}
