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
    private let useCase: LoginUseCaseType
    
    init(navigator: LoginNavigator, useCase: LoginUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
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
        let login = input.loginTrigger.withLatestFrom(usernameAndPassword)
            .map { (username, password) in
                let account = Account(username: username, password: password)
                self.useCase.login(account: account)
                    .subscribe(onSuccess: {
                        self.navigator.toHomeView()
                    }, onFailure: {error in
                        self.navigator.presentAlert(error: error as NSError)
                    })
                    .disposed(by: self.bag)
            }
        let signUp = input.signUpTrigger
            .do(onNext: navigator.toRegisterView)
        return Output(login: login, signUp: signUp)
    }
}
