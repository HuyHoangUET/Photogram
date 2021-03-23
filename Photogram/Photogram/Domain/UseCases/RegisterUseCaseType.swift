//
//  RegisterUseCase.swift
//  Photogram
//
//  Created by LTT on 17/03/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol RegisterUseCaseType {
    func signUp(account: Account) -> Observable<AuthDataResult?>
}
