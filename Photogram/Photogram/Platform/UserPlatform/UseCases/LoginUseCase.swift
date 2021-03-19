//
//  Authusecase.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginUseCase<Respositopry>: LoginUseCaseType where Respositopry: RespositoryType {
    private let respository: Respositopry
    
    init(respository: Respositopry) {
        self.respository = respository
    }
    func login(account: Account) -> Observable<NSError?> {
        return respository.login(account: account)
    }
}
