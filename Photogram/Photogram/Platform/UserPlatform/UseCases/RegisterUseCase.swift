//
//  RegisterUseCase.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

<<<<<<< HEAD:Photogram/Photogram/Platform/UserPlatform/UseCases/RegisterUseCase.swift
=======
protocol RegisterUseCaseType {
    func signUp(account: Account) -> Observable<Void>
}

>>>>>>> 43df87c... update RegisterViewModel:Photogram/Photogram/UseCases/RegisterUseCase.swift
final class RegisterUseCase<Respository>: RegisterUseCaseType where Respository: RespositoryType {
    private let respository: Respository
    
    init(respository: Respository) {
        self.respository = respository
    }
    func signUp(account: Account) -> Observable<Void> {
        return respository.signUp(account: account)
    }
}
