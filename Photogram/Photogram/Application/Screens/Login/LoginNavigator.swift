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
}

class DefaultLoginNavigator: LoginNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toHomeView() {
        let homeTabbarController = HomeTabbarController.instantiate(from: "Home", withIdentifier: "HomeTabbarController")
        navigationController.pushViewController(homeTabbarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func toRegisterView() {
        let registerViewController = RegisterViewController.instantiate(from: "Register", withIdentifier: "RegisterViewController")
        let navigator = DefaultRegisterNavigator(navigationController: self.navigationController)
        let respository = Respository()
        let useCase = RegisterUseCase(respository: respository)
        
        registerViewController.viewModel = RegisterViewModel(useCase: useCase, navigator: navigator)
        navigationController.pushViewController(registerViewController, animated: true)
    }}
