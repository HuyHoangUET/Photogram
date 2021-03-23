//
//  RegisterViewModel.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class RegisterViewModel: ViewModelType {
    private let useCase: RegisterUseCaseType
    private let navigator: RegisterNavigator
    
    init(useCase: RegisterUseCaseType, navigator: RegisterNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let confirmPassword: Driver<String>
        let registerTrigger: Driver<Void>
    }
    
    struct Output {
        let signUp: Driver<NSError?>
        let error: Driver<NSError>
        let confirmPasswordError: Driver<String?>
    }
    
    func transform(input: Input) -> Output {
        let account = Driver.combineLatest(input.username, input.password) {username, password in
            return Account(username: username, password: password)
        }
        
        let errorRelay = PublishRelay<NSError>()
        let isConfirmSuccess = Driver.combineLatest(input.password, input.confirmPassword)
            .map {password, confirmPassword -> String? in
            if password == confirmPassword {
                return nil
            } else {
                let errorConfirmPassword = "Password confimation doesn't match pasword!"
                return errorConfirmPassword
            }
        }
        let signUp = input.registerTrigger.asObservable().withLatestFrom(account)
            .flatMap {[weak self] account -> Observable<NSError?> in
                guard let self = self else {return .empty()}
                return self.useCase.signUp(account: account)
            }
            .asObservable()
            .do(onNext: {[weak self] error in
                if error == nil {
                    self?.navigator.toLogginView()
                } else {
                    errorRelay.accept(error ?? NSError())
                }
            })
            .asDriver(onErrorDriveWith: .empty())
        return Output(signUp: signUp,
                      error: errorRelay.asDriver(onErrorDriveWith: .empty()),
                      confirmPasswordError: isConfirmSuccess)
    }
}
