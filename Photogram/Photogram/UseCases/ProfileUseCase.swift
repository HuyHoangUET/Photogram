//
//  ProfileUseCase.swift
//  Photogram
//
//  Created by LTT on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileUseCaseType {
    func signOut() -> Single<Void>
}

final class ProfileUseCase<Respository>: ProfileUseCaseType where Respository: RespositoryType {
    private let respository: Respository
    
    init(respository: Respository) {
        self.respository = respository
    }
    func signOut() -> Single<Void> {
        return respository.signOut()
    }
}
