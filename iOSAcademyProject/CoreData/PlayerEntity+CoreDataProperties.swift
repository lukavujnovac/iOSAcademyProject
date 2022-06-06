//
//  PlayerEntity+CoreDataProperties.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//
//

import Foundation
import CoreData


extension PlayerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var heightFeet: Int32
    @NSManaged public var heightInches: Int32
    @NSManaged public var id: Int32
    @NSManaged public var lastName: String?
    @NSManaged public var position: String
    @NSManaged public var team: String?
    @NSManaged public var weightPounds: Int32

}

extension PlayerEntity : Identifiable {

}
