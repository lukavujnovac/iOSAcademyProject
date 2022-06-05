//
//  TeamEntity+CoreDataProperties.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 05.06.2022..
//
//

import Foundation
import CoreData


extension TeamEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }

    @NSManaged public var abbreviation: String?
    @NSManaged public var city: String?
    @NSManaged public var conference: String?
    @NSManaged public var division: String?
    @NSManaged public var fullName: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

extension TeamEntity : Identifiable {

}
