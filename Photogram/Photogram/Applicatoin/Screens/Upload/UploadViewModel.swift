//
//  UploadViewModel.swift
//  Photogram
//
//  Created by LTT on 10/03/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UploadViewModel: ViewModelType {
    var navigator: UploadNavigator
    let picker = UIImagePickerController()
    
    init(navigator: UploadNavigator) {
        self.navigator = navigator
    }
    
    struct Input {
        let chooseTriger: Driver<Void>
        let uploadTrigger: Driver<Void>
    }
    
    struct Output {
        let choosePhoto: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let choosePhoto = input.chooseTriger
            .do(onNext: {
                self.navigator.presentChoosePhoto(picker: self.picker)
            })
        return Output(choosePhoto: choosePhoto)
    }
}
