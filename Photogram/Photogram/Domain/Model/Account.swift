//
//  Account.swift
//  Photogram
//
//  Created by LTT on 21/01/2021.
//

import Foundation

class Account {
    var username = ""
    var password = ""
    init() {
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
