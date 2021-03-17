//
//  RegisterUseCase.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class RegisterUseCase<Respository>: RegisterUseCaseType where Respository: RespositoryType {
    private let respository: Respository
    
    init(respository: Respository) {
        self.respository = respository
    }
    
    func signUp(account: Account, isConfirmSuccess: Bool) -> Observable<String?> {
        return respository.signUp(account: account,
                                  isConfirmSuccess: isConfirmSuccess)
    }
}
