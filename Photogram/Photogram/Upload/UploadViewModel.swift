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
    private let bag = DisposeBag()
    
    struct Input {
        let photoImageTriger: Observable<Void>
        let photoImage: Observable<UIImage>
        let uploadButtonTrigger: Observable<Void>
    }
    
    struct Output {
        let loadPhoto: Driver<Void>
    }
    
//    func transform(input: Input) -> Output {
//        var image = UIImage()
//        input.photoImage
//            .subscribe(onNext: {photoImage in
//                image = photoImage
//                
//            })
//            .disposed(by: bag)
//        return Output(didUpload: <#T##Driver<Void>#>)
//    }
}
