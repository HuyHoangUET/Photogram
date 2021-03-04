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
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toHomeView() {
        let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController.present(homeView, animated: true, completion: nil)
    }
    
    func toRegisterView() {
        let registerView = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController.pushViewController(registerView, animated: true)
    }
}
