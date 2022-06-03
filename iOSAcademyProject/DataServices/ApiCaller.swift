//
//  ApiCaller.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 31.05.2022..
//

import Foundation

final class ApiCaller {
    
    static let shared = ApiCaller()
    
    struct Constants {
        static let allTeamsURL = URL(string: "https://www.balldontlie.io/api/v1/teams")
        static let allPLayersURL = URL(string: "https://www.balldontlie.io/api/v1/players")
        static let playerImageURL = "https://academy-2022.dev.sofascore.com/api/v1/academy/player-image/player/"
    }
    
    private init() {}
    
    public func getPlayers(completition: @escaping (Result<[Player], Error>) -> Void) {
        guard let url = Constants.allPLayersURL else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completition(.failure(error))
            }else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(ApiPlayerResponse.self, from: data)
                    completition(.success(result.data))
                }catch {
                    completition(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getTeams(completition: @escaping(Result<[Team], Error>) -> Void) {
        guard let url = Constants.allTeamsURL else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completition(.failure(error))
            }else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(ApiTeamResponse.self, from: data)
                    
                    print("Teams: \(result.data.count)")
                    completition(.success(result.data))
                }catch {
                    completition(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}

struct ApiTeamResponse: Codable {
    let data: [Team]
}

struct Team: Codable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String
}

struct ApiPlayerResponse: Codable {
    let data: [Player]
}

struct Player: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let heightFeet: Int?
    let heightInches: Int?
    let weightPounds: Int?
    let team: Team
}
