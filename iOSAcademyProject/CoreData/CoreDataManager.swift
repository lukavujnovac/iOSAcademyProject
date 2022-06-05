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
    
    func team(id: Int32, abbreviation: String, city: String, conference: String, division: String, fullName: String, name: String, isFavorite: Bool) -> TeamEntity {
        let teamE = TeamEntity(context: persistentContainer.viewContext)
        
        teamE.id = id
        teamE.abbreviation = abbreviation
        teamE.city = city
        teamE.conference = conference
        teamE.division = division
        teamE.fullName = fullName   
        teamE.name = name
        teamE.isFavorite = isFavorite
        favoriteTeams.append(teamE)
        saveContext()
        
        return teamE
    }
    
    lazy var  persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JSonToCoreData")
        container.loadPersistentStores { storedescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }() 
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("unresolved error \(error)")
            }
        }
    }
    
    func delete(object: TeamEntity) {
        let context = persistentContainer.viewContext
        context.delete(object)
        
        do {
            try context.save()
        }catch {
            let nserror = error as NSError
            fatalError("unresolved error \(error)")
        }
    }
    
    func teams() -> [TeamEntity] {
        let request: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        var fetchedTeams: [TeamEntity] = []
        
        do {
            fetchedTeams = try persistentContainer.viewContext.fetch(request)
        }catch {
            print("error fetching budgets")
        }
        
        return fetchedTeams
    }
}
