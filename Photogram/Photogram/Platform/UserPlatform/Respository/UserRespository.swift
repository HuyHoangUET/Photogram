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
    func login(account: Account) -> Observable<AuthData>
    func signUp(account: Account) -> Observable<AuthData>
    func signOut() -> Single<Void>
}

final class Respository: RespositoryType {
    func login(account: Account) -> Observable<AuthData> {
        return Observable.create { obsever in
            Auth.auth().signIn(withEmail: account.username, password: account.password) {result, error in
                if let error = error as NSError? {
                    obsever.onNext(AuthData(result: nil, error: error))
                } else {
                    obsever.onNext(AuthData(result: result, error: nil))
                }
                obsever.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func signUp(account: Account) -> Observable<AuthData> {
        return Observable.create { obsever in
            Auth.auth().createUser(withEmail: account.username, password: account.password) { result, error in
                if let error = error as NSError? {
                    obsever.onNext(AuthData(result: nil, error: error))
                } else {
                    obsever.onNext(AuthData(result: result, error: nil))
                }
                obsever.onCompleted()
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
