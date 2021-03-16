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

protocol AbstractResponsitory {
    associatedtype T
    func signIn(account: T) -> Observable<NSError>
    func signUp(account: T) -> Observable<NSError>
    func signOut() -> Observable<Void>
}

final class Responsitory<T: Account>: AbstractResponsitory {
    func signIn(account: T) -> Observable<NSError> {
        return Observable.create { observer in
            Auth.auth().signIn(withEmail: account.username, password: account.password) {_, error in
                if let error = error as NSError? {
                    observer.onNext(error)
                    observer.onCompleted()
                } else {
                    observer.onNext(NSError())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func signUp(account: T) -> Observable<NSError> {
        return Observable.create { observer in
            Auth.auth().createUser(withEmail: account.username, password: account.password) { _, error in
                if let error = error as NSError? {
                    observer.onNext(error)
                    observer.onCompleted()
                } else {
                    observer.onNext(NSError())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func signOut() -> Observable<Void> {
        return Observable.create {_ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("error")
            }
            return Disposables.create()
        }
    }
    
}
