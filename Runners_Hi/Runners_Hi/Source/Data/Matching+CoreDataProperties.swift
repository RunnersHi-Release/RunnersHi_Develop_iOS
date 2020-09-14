//
//  Matching+CoreDataProperties.swift
//  
//
//  Created by 김민희 on 2020/09/14.
//
//

import Foundation
import CoreData


extension Matching {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Matching> {
        return NSFetchRequest<Matching>(entityName: "Matching")
    }

    @NSManaged public var gender: Int16
    @NSManaged public var goalTime: Int16

}
