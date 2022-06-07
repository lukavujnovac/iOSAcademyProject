//
//  GameViewModel.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 07.06.2022..
//

import Foundation

class GameViewModel {
    let id: Int
    let date: String
    let homeTeamScore: Int
    let visitorTeamScore: Int
    let season: Int
    let period: Int
    let status: String
    let time: String
    let postseason: Bool
    let homeTeam: Team
    let visitorTeam: Team
    
    init(id: Int, date: String, homeTeamScore: Int, visitorTeamScore: Int, season: Int, period: Int, status: String, time: String, postseason: Bool, homeTeam: Team, visitorTeam: Team) {
        self.id = id
        self.date = date
        self.homeTeamScore = homeTeamScore
        self.visitorTeamScore = visitorTeamScore
        self.season = season
        self.period = period
        self.status = status
        self.time = time
        self.postseason = postseason
        self.homeTeam = homeTeam
        self.visitorTeam = visitorTeam
    }
}
