//
//  CoreDataManager.swift
//  CoreData-NumberFacts
//
//  Created by Brendon Crowe on 5/3/23.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]() // User is a NSManagedObject
    private var posts = [Post]() // Post is a NSManagedObject
    
    // access the persistence container reference in the AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // view context is of type NSManagedObjectContext
    
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        do {
            try context.save() // save changes to the NSManagedObjectContext
        } catch {
            print("Error creating user: \(error.localizedDescription)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest()) // fetchRequest gets all the objects from CoreDate
            // NSPredicate can be used to sort and filter Core Data objects during fetching
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
        return users
    }
}
