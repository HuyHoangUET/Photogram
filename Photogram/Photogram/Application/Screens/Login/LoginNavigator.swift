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
    func presentAlert(error: NSError)
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
    
    func presentAlert(error: NSError) {
        let alertController: UIAlertController = UIAlertController(title: "Login failed!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
