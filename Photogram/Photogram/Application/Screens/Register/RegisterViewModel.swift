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
        let signUp: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let account = Driver.combineLatest(input.username, input.password) {username, password in
            return Account(username: username, password: password)
        }
        var isConfirmSuccess = true
        _ = Driver.combineLatest(input.password, input.confirmPassword)
            .map {password, confirmPassword in
            if password == confirmPassword {
                isConfirmSuccess = true
            } else {
                isConfirmSuccess = false
            }
        }
        let signUp = input.registerTrigger.asObservable().withLatestFrom(account)
            .flatMap {[weak self] account -> Observable<Void> in
                guard let self = self else {return .empty()}
                if isConfirmSuccess {
                    return self.useCase.signUp(account: account)
                } else {
                    self.navigator.presentConfirmPasswordAlert()
                    return .empty()
                }
            }
            .do(onNext: {[weak self] in
                self?.navigator.toLoggin()
            }, onError: {[weak self] error in
                self?.navigator.presentAlert(error: error as NSError)
            })
            .asDriver(onErrorDriveWith: .empty())
        return Output(signUp: signUp)
    }
    func requestRegister(email: String, password: String, completetion: @escaping (NSError) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error as NSError? {
                completetion(error)
            } else {
                completetion(NSError())
            }
        }
    }
}
