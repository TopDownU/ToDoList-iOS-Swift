//
//  Tasks+CoreDataProperties.swift
//  
//
//  Created by Vidyadhar V. Thatte on 11/1/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var task: String?

}
