//
//  AuthData.swift
//  Photogram
//
//  Created by Phạm Hoàng on 10/04/2021.
//

import Foundation
import FirebaseAuth

class AuthData {
    var result: AuthDataResult
    var error: NSError
    
    init(result: AuthDataResult, error: NSError) {
        self.result = result
        self.error = error
    }
}
