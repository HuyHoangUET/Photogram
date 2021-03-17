//
//  HomeTabbarNavigator.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit

protocol HomeTabbarNavigator {
    func logOut()
}

class DefaultHomeTabbarNavigator: HomeTabbarNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func logOut() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        let navigator = DefaultLoginNavigator(navigationController: self.navigationController)
        let respository = Respository()
        let useCase = LoginUseCase(respository: respository)
        loginView.viewModel = LoginViewModel(navigator: navigator, useCase: useCase)
        navigationController.setViewControllers([loginView], animated: true)
    }
}
