//
//  CoreDataManager.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    private override init() {
//        super.init()
    }
    static let _shared = CoreDataManager()
    
    class func shared() -> CoreDataManager {
        return _shared
    }
    
    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1])
        return urls[urls.count - 1]
    }()
    
    private func applicationLibraryDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    lazy var managedObjectContext = {
        return self.peristentContainer.viewContext
    }()
    
    lazy var peristentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JSonToCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func prepare(dataForSaving: [Team]) {
        _ = dataForSaving.map{self.createEntityFrom(team: $0)}
//        saveData()
    }
    
    private func createEntityFrom(team: Team) -> TeamItem? {
        guard let id = team.id, let name = team.name, let abbreviation = team.abbreviation, let city = team.city, let conference = team.conference, let division = team.division, let fullName = team.fullName else {return nil}
        
        //convert
        let teamItem = TeamItem(context: self.managedObjectContext)
        teamItem.id = Int32(id)
        teamItem.name = name
        teamItem.abbreviation = abbreviation
        teamItem.city = city
        teamItem.conference = conference
        teamItem.division = division
        teamItem.fullName = fullName
        
        return teamItem
    }
    
    func saveData() {
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nsError = error as NSError
                fatalError("unresolved error \(nsError)")
            }
        }
    }
    
    func saveDataInBackground() {
        peristentContainer.performBackgroundTask { context in
            if context.hasChanges {
                do {
                    try context.save()
                }catch {
                    let nsError = error as NSError
                    fatalError("unresolved error \(nsError)")
                }
            }
        }
    }
}
