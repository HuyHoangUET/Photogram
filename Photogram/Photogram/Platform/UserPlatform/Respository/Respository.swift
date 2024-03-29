//
//  Respository.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol RespositoryType {
    func login(account: Account) -> Observable<Void>
    func signUp(account: Account, isConfirmSuccess: Bool) -> Observable<String?>
    func signOut() -> Single<Void>
}

final class Respository: RespositoryType {
    func login(account: Account) -> Observable<Void> {
        return Observable.create { obsever in
            Auth.auth().signIn(withEmail: account.username, password: account.password) {_, error in
                if let error = error as NSError? {
                    obsever.onError(error)
                } else {
                    obsever.onNext(())
                }
                obsever.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func signUp(account: Account, isConfirmSuccess: Bool) -> Observable<String?> {
        return Observable.create { obsever in
            if isConfirmSuccess {
                Auth.auth().createUser(withEmail: account.username, password: account.password) { _, error in
                    if let error = error as NSError? {
                        obsever.onError(error)
                    } else {
                        obsever.onNext(nil)
                    }
                }
            } else {
                obsever.onNext("Password confimation doesn't match password!")
            }
            return Disposables.create()
        }
    }
    
    func signOut() -> Single<Void> {
        return Single.create {single in
            do {
                single(.success(try Auth.auth().signOut()))
            } catch let error {
                print("signOut failed: \(error.localizedDescription)")
            }
            return Disposables.create()
        }
    }
    
}
