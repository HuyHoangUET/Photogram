//
//  LoginUseCase.swift
//  Photogram
//
//  Created by LTT on 17/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginUseCaseType {
    func login(account: Account) -> Observable<AuthData>
}
