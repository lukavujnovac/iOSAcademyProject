//
//  UserDefaults+Helpers.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 24.05.2022..
//

import Foundation

extension UserDefaults {
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}
