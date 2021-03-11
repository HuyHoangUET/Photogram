//
//  RegisterViewModel.swift
//  Photogram
//
//  Created by LTT on 22/01/2021.
//

import Foundation
import Firebase

class RegisterViewModel {
    func requestRegister(email: String, password: String, completetion: @escaping (NSError) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error as NSError? {
                completetion(error)
            } else {
                completetion(NSError())
            }
        }
    }
}
