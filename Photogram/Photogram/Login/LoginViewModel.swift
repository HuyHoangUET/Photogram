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
    struct Input {
        var user = PublishSubject<User>()
    }
    struct Output {
        var loginRespone = PublishSubject<Bool>()
        var error = PublishSubject<NSError>()
    }
    
    var input = Input()
    var output = Output()
    private var bag = DisposeBag()
    
    func handleLogin() {
        input.user.subscribe(onNext: {user in
            Auth.auth().signIn(withEmail: user.account.username, password: user.account.password) {authResult, error in
                if let error = error as NSError? {
                    self.output.error.onNext(error)
                } else {
                    self.output.loginRespone.onNext(true)
                }
            }
        })
        .disposed(by: bag)
    }
}
