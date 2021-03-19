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
        let login: Driver<NSError?>
        let signUp: Driver<Void>
        let error: Driver<NSError>
    }
    
    func transform(input: Input) -> Output {
        let account = Driver.combineLatest(input.username,
                                           input.password) {username, password in
            return Account(username: username,
                           password: password)
        }
        let errorDriver = PublishRelay<NSError>()
        
        let login = input.loginTrigger
            .asObservable()
            .withLatestFrom(account)
            .flatMap { [weak self] account -> Observable<NSError?> in
                guard let self = self else {return .empty()}
                return (self.useCase.login(account: account)).asObservable()
            }
            .do(onNext: {[weak self] error in
                if error == nil {
                    self?.navigator.toHomeView()
                } else {
                    errorDriver.accept(error ?? NSError())
                }
            })
            .asDriver(onErrorDriveWith: .empty())
        
        let signUp = input.signUpTrigger
            .do(onNext: navigator.toRegisterView)
        return Output(login: login,
                      signUp: signUp,
                      error: errorDriver.asDriver(onErrorDriveWith: .empty()))
    }
}
