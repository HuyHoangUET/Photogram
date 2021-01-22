//
//  LoginViewModel.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import Firebase
import RxSwift

class LoginViewModel {
    var user = User()
    var errorMessage = ""
    
//    func requestLogin() -> Observable<String> {
//        return Observable.create { observer in
//            Auth.auth().signIn(withEmail: self.user.account.username,
//                               password: self.user.account.password) { (authResult, error) in
//                if let error = error as NSError? {
//                    observer.onNext(error.localizedDescription)
//                } else {
//                    observer.onNext("")
//                    print("Login success.")
//                }
//                observer.onCompleted()
//            }
//            return Disposables.create()
//        }
//    }
}
