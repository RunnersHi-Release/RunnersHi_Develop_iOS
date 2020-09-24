//
//  Information+CoreDataProperties.swift
//  
//
//  Created by 김민희 on 2020/09/25.
//
//

import Foundation
import CoreData


extension Information {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Information> {
        return NSFetchRequest<Information>(entityName: "Information")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var nickname: String?
    @NSManaged public var gender: Int16
    @NSManaged public var image: Int16
    @NSManaged public var badge: String?
    @NSManaged public var win: Int16
    @NSManaged public var lose: Int16

}
