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
    
    func favoriteTeams() -> [String]? {
        if array(forKey: "favoriteTeams") == nil {
            return [""] 
        }else {
            return array(forKey: "favoriteTeams") as! [String]
        }
    }
    
    func resetFavoriteTeams() {
        return removeObject(forKey: "favoriteTeams")
    }
}
