//
//  CoreDataManager.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/09/14.
//  Copyright © 2020 김민희. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Users"
    
    func getUsers(ascending: Bool = false) -> [Matching] {
        var models: [Users] = [Users]()
    }
    
    
}
