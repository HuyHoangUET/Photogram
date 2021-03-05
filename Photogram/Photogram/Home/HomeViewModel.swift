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
    private let navigator: HomeNavigator
    
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
            .do(onNext: navigator.logout)
        return Output(logout: logout)
    }
}
