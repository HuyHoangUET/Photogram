//
//  ProfileNavigator.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

protocol ProfileNavigator {
    func logout()
    func toUploadView()
}

class DefaultProfileNavigator: ProfileNavigator {
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        let loginNavigationController = UINavigationController(rootViewController: loginView)
        let navigator = DefaultLoginNavigator(navigationController: self.navigationController)
        loginView.viewModel = LoginViewModel(navigator: navigator)
        navigationController.setViewControllers([loginView], animated: true)
    }
    
    func toUploadView() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let uploadView = storyboard.instantiateViewController(identifier: "UploadViewController") as UploadViewController
        navigationController.pushViewController(uploadView, animated: true)
    }
    
}
