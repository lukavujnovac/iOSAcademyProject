//
//  PlayerViewModel.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 07.06.2022..
//

import Foundation

class PlayerViewModel: Equatable {
    static func == (lhs: PlayerViewModel, rhs: PlayerViewModel) -> Bool {
        return lhs.id == rhs.id && lhs.firstName == rhs.firstName && lhs.heightFeet == rhs.heightFeet && lhs.heightInches == rhs.heightInches && lhs.position == rhs.position && lhs.team == rhs.team && lhs.weightPounds == rhs.weightPounds
    }
    
    let id: Int
    let firstName: String
    let lastName: String
    let heightFeet: Int
    let heightInches: Int
    let position: String
    let team: Team
    let weightPounds: Int
    var isFavorite: Bool = false
    
    init(id: Int, firstName: String, lastName: String, heightFeet: Int, heightInches: Int, position: String, team: Team, weightPounds: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.heightFeet = heightFeet
        self.heightInches = heightInches
        self.position = position
        self.team = team
        self.weightPounds = weightPounds
    }
}
