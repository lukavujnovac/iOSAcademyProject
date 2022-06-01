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
        static let teamsSearchURL = "https://www.balldontlie.io/api/v1/teams/"
    }
    
    private init() {}
    
    public func getTeams(completition: @escaping(Result<[Team], Error>) -> Void) {
        guard let url = Constants.allTeamsURL else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completition(.failure(error))
            }else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
                    print("Teams: \(result.data.count)")
                    completition(.success(result.data))
                }catch {
                    completition(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func searchTeam(with teamId: String, completition: @escaping(Result<[Team], Error>) -> Void) {
        guard !teamId.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        let urlString = Constants.teamsSearchURL + teamId
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completition(.failure(error))
            }else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
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

struct ApiResponse: Codable {
    let data: [Team]
}

struct Team: Codable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let full_name: String
    let name: String
}
