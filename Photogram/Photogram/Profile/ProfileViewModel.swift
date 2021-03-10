//
//  ProfileViewModel.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import Firebase
import UIKit
import RxSwift
import RxCocoa

class ProfileViewmodel: ViewModelType {
    private var bag = DisposeBag()
    var navigator: ProfileNavigator
    
    init(navigator: ProfileNavigator) {
        self.navigator = navigator
    }
    
    struct Input {
        let logoutTrigger: Driver<Void>
    }
    
    struct Output {
        let logout: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let logout = input.logoutTrigger
            .do(onNext: {
                do {
                    try Auth.auth().signOut()
                    self.navigator.logout()
                } catch {
                    print("error")
                }
            })
        return Output(logout: logout)
    }
}
