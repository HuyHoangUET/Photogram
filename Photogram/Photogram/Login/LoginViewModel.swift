//
//  LoginViewModel.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation
import Firebase

class LoginViewModel {
    var user = User()
    
    func requestLogin(complettion: @escaping (NSError) -> Void) {
        Auth.auth().signIn(withEmail: self.user.account.username,
                           password: self.user.account.password) { (authResult, error) in
            if let error = error as NSError? {
                complettion(error)
            } else {
                complettion(NSError())
                print("Login success.")
            }
        }
    }
}
