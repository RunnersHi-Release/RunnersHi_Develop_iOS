//
//  Information+CoreDataProperties.swift
//  
//
//  Created by 최영재 on 2020/11/24.
//
//

import Foundation
import CoreData


extension Information {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Information> {
        return NSFetchRequest<Information>(entityName: "Information")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var badge: [Bool]?
    @NSManaged public var gender: Int64
    @NSManaged public var image: Int64
    @NSManaged public var level: Int64
    @NSManaged public var lose: Int64
    @NSManaged public var nickname: String?
    @NSManaged public var win: Int64

}
