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
    
    let infoModel: String = "Information"
    let opponentModel: String = "Opponent"
    
    func getUsers(ascending: Bool = false) -> [Information] {
        var userModels: [Information] = [Information]()
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "accessToken", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: infoModel)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Information] = try context.fetch(fetchRequest) as? [Information] {
                    userModels = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return userModels
    }
    func getOpponent(ascending: Bool = false) -> [Opponent] {
        var opponentModels: [Opponent] = [Opponent]()
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "nickname", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: opponentModel)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Opponent] = try context.fetch(fetchRequest) as? [Opponent] {
                    opponentModels = fetchResult
            }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return opponentModels
        
    }
    func saveUser(accessToken: String, nickname: String, gender: Int64, image: Int64, badge: String, win: Int64, lose: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: infoModel, in: context) {
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
    func saveOpponent(level: Int64, lose: Int64, nickname: String, profileImage: Int64, win: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
           let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: opponentModel, in: context) {
            if let opponent: Opponent = NSManagedObject(entity: entity, insertInto: context) as? Opponent {
                opponent.level = level
                opponent.lose = lose
                opponent.nickname = nickname
                opponent.profileImage = profileImage
                opponent.win = win
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    func deleteUser(onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest()

        do {
            if let results: [Information] = try context?.fetch(fetchRequest) as? [Information] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fatch🥺: \(error), \(error.userInfo)")
            onSuccess(false)
        }

        contextSave { success in
            onSuccess(success)
        }
    }
    
}
extension CoreDataManager {
    fileprivate func filteredRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: infoModel)
//        fetchRequest.predicate = NSPredicate(format: "accessToken = %@", (token) as! CVarArg)
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
