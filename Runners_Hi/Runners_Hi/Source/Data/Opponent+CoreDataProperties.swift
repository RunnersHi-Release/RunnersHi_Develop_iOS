//
//  Opponent+CoreDataProperties.swift
//  
//
//  Created by 김민희 on 2020/09/14.
//
//

import Foundation
import CoreData


extension Opponent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Opponent> {
        return NSFetchRequest<Opponent>(entityName: "Opponent")
    }

    @NSManaged public var level: Int16
    @NSManaged public var lose: Int16
    @NSManaged public var nickname: String?
    @NSManaged public var profileImage: Int16
    @NSManaged public var win: Int16

}
