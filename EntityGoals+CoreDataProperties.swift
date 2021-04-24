//
//  EntityGoals+CoreDataProperties.swift
//  
//
//  Created by Eduardo Jordan on 24/4/21.
//
//

import Foundation
import CoreData


extension EntityGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityGoals> {
        return NSFetchRequest<EntityGoals>(entityName: "EntityGoals")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var goal: Int64
    @NSManaged public var points: Int64
    @NSManaged public var title: String?
    @NSManaged public var trophy: String?
    @NSManaged public var type: String?
    @NSManaged public var id: String?
}
