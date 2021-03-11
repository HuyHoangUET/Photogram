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
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
