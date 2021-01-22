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
    var errorMessage = ""
    var loginSuccess = true
    
    func requestLogin(complettion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: self.user.account.username,
                           password: self.user.account.password) { (authResult, error) in
            if let error = error as NSError? {
                self.errorMessage = error.localizedDescription
                complettion(false)
            } else {
                complettion(true)
                print("Login success.")
            }
        }
    }
}
