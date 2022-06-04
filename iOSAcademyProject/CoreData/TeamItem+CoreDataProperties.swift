//
//  TeamItem+CoreDataProperties.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//
//

import Foundation
import CoreData


extension TeamItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamItem> {
        return NSFetchRequest<TeamItem>(entityName: "TeamItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var abbreviation: String?
    @NSManaged public var city: String?
    @NSManaged public var conference: String?
    @NSManaged public var division: String?
    @NSManaged public var fullName: String?
    @NSManaged public var name: String?

}

extension TeamItem : Identifiable {

}
