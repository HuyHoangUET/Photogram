//
//  HomeNavigator.swift
//  Photogram
//
//  Created by LTT on 04/03/2021.
//

import Foundation
import UIKit
import Firebase

protocol HomeNavigator {
    func logout()
}

class DefaultHomeNavigator: HomeNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        let navigator = DefaultLoginNavigator(navigationController: self.navigationController)
        loginView.viewModel = LoginViewModel(navigator: navigator)
        navigationController.setViewControllers([loginView], animated: true)
    } 
}
