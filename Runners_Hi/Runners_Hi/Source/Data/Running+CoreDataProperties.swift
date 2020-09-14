//
//  Running+CoreDataProperties.swift
//  
//
//  Created by 김민희 on 2020/09/14.
//
//

import Foundation
import CoreData


extension Running {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Running> {
        return NSFetchRequest<Running>(entityName: "Running")
    }

    @NSManaged public var distance: Int16
    @NSManaged public var endTime: String?
    @NSManaged public var room: Int16
    @NSManaged public var startTime: String?

}
