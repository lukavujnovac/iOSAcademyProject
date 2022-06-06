//
//  CoreDataManager.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 05.06.2022..
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    var favoriteTeams: [TeamEntity] = []
    var favoritePlayers: [PlayerEntity] = []
    
    func player(id: Int32, firstName: String, lastName: String, position: String, heightFeet: Int32, heightInches: Int32, weightPounds: Int32, team: String) -> PlayerEntity{
        let playerE = PlayerEntity(context: persistentContainerTeams.viewContext)
        
        playerE.id = id
        playerE.firstName = firstName
        playerE.lastName = lastName
        playerE.position = position
        playerE.heightFeet = heightFeet
        playerE.heightInches = heightInches
        playerE.weightPounds = weightPounds
        playerE.team = team
        
        return playerE
    }
    
    func team(id: Int32, abbreviation: String, city: String, conference: String, division: String, fullName: String, name: String, isFavorite: Bool) -> TeamEntity {
        let teamE = TeamEntity(context: persistentContainerTeams.viewContext)
        
        teamE.id = id
        teamE.abbreviation = abbreviation
        teamE.city = city
        teamE.conference = conference
        teamE.division = division
        teamE.fullName = fullName   
        teamE.name = name
        teamE.isFavorite = isFavorite
        favoriteTeams.append(teamE)
        saveContextTeams()
        
        return teamE
    }
    
    lazy var  persistentContainerTeams: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JSonToCoreData")
        container.loadPersistentStores { storedescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()  
    
    func saveContextTeams() {
        let context = persistentContainerTeams.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("unresolved error \(nserror)")
            }
        }
    }
    
    func deleteTeams(object: TeamEntity) {
        let context = persistentContainerTeams.viewContext
        context.delete(object)
        
        do {
            try context.save()
        }catch {
            let nserror = error as NSError
            fatalError("unresolved error \(nserror)")
        }
    }
    
    func deletePlayers(object: PlayerEntity) {
        let context = persistentContainerTeams.viewContext
        context.delete(object)
        
        do {
            try context.save()
        }catch {
            let nserror = error as NSError
            fatalError("unresolved error \(nserror)")
        }
    }
    
    func teams() -> [TeamEntity] {
        let request: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        var fetchedTeams: [TeamEntity] = []
        
        do {
            fetchedTeams = try persistentContainerTeams.viewContext.fetch(request)
        }catch {
            print("error fetching teams")
        }
        
        return fetchedTeams
    }
    
    func players() -> [PlayerEntity] {
        let request: NSFetchRequest<PlayerEntity> = PlayerEntity.fetchRequest()
        
        var fetchedPlayers: [PlayerEntity] = []
        
        do {
            fetchedPlayers = try persistentContainerTeams.viewContext.fetch(request)
        } catch {
            print("error fetching players")
        }
        
        return fetchedPlayers
    }
}
