//
//  ProfileNavigator.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

protocol ProfileNavigator {
    func logOut()
    func toUploadView()
}

class DefaultProfileNavigator: ProfileNavigator {
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func logOut() {
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
        let navigator = DefaultUploadNavigator(navigationController: self.navigationController)
        uploadView.viewModel = UploadViewModel(navigator: navigator)
        navigationController.pushViewController(uploadView, animated: true)
    }
    
}
