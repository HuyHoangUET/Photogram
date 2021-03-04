//
//  LoginViewModel.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import Firebase
import UIKit
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    private var bag = DisposeBag()
    private let navigator: LoginNavigator
    
    init(navigator: LoginNavigator) {
        self.navigator = navigator
    }
    
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let loginTrigger: Driver<Void>
        let signUpTrigger: Driver<Void>
    }
    struct Output {
        let login: Driver<Void>
        let signUp: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let usernameAndPassword = Driver.combineLatest(input.username, input.password)
        var loginError = ""
        let login = input.loginTrigger.withLatestFrom(usernameAndPassword)
            .map { (username, password) in
                Auth.auth().signIn(withEmail: username, password: password) {authResult, error in
                    if let error = error as NSError? {
                        loginError = error.localizedDescription
                    } else {
                        self.navigator.toHomeView()
                    }
                }
            }
        let signUp = input.signUpTrigger
            .do(onNext: navigator.toRegisterView)
        return Output(login: login, signUp: signUp)
    }
}

