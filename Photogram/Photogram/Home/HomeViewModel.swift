//
//  HomeViewModel.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import Firebase
import UIKit
import RxSwift
import RxCocoa

class HomeViewmodel: ViewModelType {
    private var bag = DisposeBag()
    var navigator: HomeNavigator
    
    init(navigator: HomeNavigator) {
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
