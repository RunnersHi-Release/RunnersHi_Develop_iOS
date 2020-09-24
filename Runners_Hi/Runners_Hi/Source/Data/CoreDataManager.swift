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
    
    let modelName: String = "Information"
    
    func getUsers(ascending: Bool = false) -> [Information] {
        var models: [Information] = [Information]()
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "accessToken", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Information] = try context.fetch(fetchRequest) as? [Information] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    func saveUser(accessToken: String, nickname: String, gender: Int64, image: Int64, badge: String, win: Int64, lose: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let user: Information = NSManagedObject(entity: entity, insertInto: context) as? Information {
                user.accessToken = accessToken
                user.nickname = nickname
                user.gender = gender
                user.image = image
                user.badge = badge
                user.win = win
                user.lose = lose
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
//    func deleteUser(id: Int64, onSuccess: @escaping ((Bool) -> Void)) {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
//
//        do {
//            if let results: [Matching] = try context?.fetch(fetchRequest) as? [Matching] {
//                if results.count != 0 {
//                    context?.delete(results[0])
//                }
//            }
//        } catch let error as NSError {
//            print("Could not fatch🥺: \(error), \(error.userInfo)")
//            onSuccess(false)
//        }
//
//        contextSave { success in
//            onSuccess(success)
//        }
//    }
    
}
extension CoreDataManager {
    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
