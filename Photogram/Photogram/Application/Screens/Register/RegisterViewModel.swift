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
        let confirmPasswordError: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let account = Driver.combineLatest(input.username, input.password) {username, password in
            return Account(username: username, password: password)
        }
        
        let errorRelay = PublishRelay<NSError>()
        let confirmPasswordErrorRelay = PublishRelay<String>()
        let isConfirmSuccess = Driver.combineLatest(input.password, input.confirmPassword)
            .map {password, confirmPassword -> Bool in
            if password == confirmPassword {
                return true
            } else {
                return false
            }
        }
        var isSuccess = true
        let isConfirmSuccessAccount = Driver.combineLatest(isConfirmSuccess, account)
        let signUp = input.registerTrigger.asObservable().withLatestFrom(isConfirmSuccessAccount)
            .flatMap {[weak self] isConfirmSuccess, account -> Observable<NSError?> in
                guard let self = self else {return .empty()}
                isSuccess = isConfirmSuccess
                return self.useCase.signUp(account: account, isConfirmSuccess: isConfirmSuccess)
            }
            .asObservable()
            .do(onNext: {[weak self] error in
                if error == nil {
                    if isSuccess {
                        self?.navigator.toLogginView()
                    } else {
                        let errorConfirmPassword = "Password confimation doesn't match pasword!"
                        confirmPasswordErrorRelay.accept(errorConfirmPassword)
                    }
                } else {
                    errorRelay.accept(error ?? NSError())
                }
            })
            .asDriver(onErrorDriveWith: .empty())
        return Output(signUp: signUp,
                      error: errorRelay.asDriver(onErrorDriveWith: .empty()),
                      confirmPasswordError: confirmPasswordErrorRelay.asDriver(onErrorDriveWith: .empty()))
    }
}
