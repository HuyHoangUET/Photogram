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
    
    func requestLogin() {
        Auth.auth().signIn(withEmail: user.account.username, password: user.account.password) { (authResult, error) in
            if let error = error as NSError? {
                print(self.user.account.username)
                print(error.localizedDescription)
            } else {
                print("login success")
            }
        }
    }
}
