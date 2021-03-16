//
//  Authusecase.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol AuthUseCaseType {
    func signIn(account: Account) -> Single<Void>
    func singUp(account: Account) -> Single<Void>
    func signOut() -> Single<Void>
}

final class AuthUseCase<Respositopry>: AuthUseCaseType where Respositopry: RespositoryType {
    private let respository: Respositopry
    
    init(respository: Respositopry) {
        self.respository = respository
    }
    func signIn(account: Account) -> Single<Void> {
        return respository.signIn(account: account)
    }
    
    func singUp(account: Account) -> Single<Void> {
        return respository.signUp(account: account)
    }
    
    func signOut() -> Single<Void> {
        return respository.signOut()
    }
}
