//
//  TeamViewModel.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 07.06.2022..
//

import Foundation

class TeamViewModel {
    let fullName: String
    let id: Int
    let abbreviation: String
    let city: String
    let division: String
    let imageString: String
    let conference: String
    let name: String
    var isFavorite: Bool = false
    
    init(fullName: String, id: Int, abbreviation: String, city: String, division: String, imageString: String, conference: String, name: String) {
        self.fullName = fullName
        self.id = id
        self.abbreviation = abbreviation
        self.city = city
        self.division = division
        self.imageString = imageString
        self.conference = conference
        self.name = name
    }
}
