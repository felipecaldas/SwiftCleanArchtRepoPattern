//
//  UsersCoreDataSore.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import CoreData

class UsersCoreDataStore: UsersStoreProtocol {
 
    // MARK: - Managed object contexts
    
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext
    
    // MARK: - Object lifecycle
    
    init()
    {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("BabyNamesv2", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* The directory the application uses to store the Core Data store file.
        This code uses a file named "DataModel.sqlite" in the application's documents directory.
        */
        let storeURL = docURL.URLByAppendingPathComponent("BabyNamesv2.sqlite")
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateManagedObjectContext.parentContext = mainManagedObjectContext
    }
    
    deinit
    {
        do {
            try self.mainManagedObjectContext.save()
        } catch {
            fatalError("Error deinitializing main managed object context")
        }
    }
    
    /*func fetchUsers(completionHandler: (users: () throws -> [User]) -> Void) {
        privateManagedObjectContext.performBlock {
            do {
                let fetchRequest = NSFetchRequest(entityName: "ManagedUser")
                let results = try self.privateManagedObjectContext.executeFetchRequest(fetchRequest) as! [ManagedUser]
                let users = results.map { $0.toUser() }
                completionHandler { return users }
            } catch {
                completionHandler { throw UsersStoreError.CannotFetch("Cannot fetch users") }
            }
        }
    }*/
    
    func createUser(userToCreate: User, completionHandler: (error: UsersStoreError?) -> Void) {
        privateManagedObjectContext.performBlock {
            do {
                let managedOrder = NSEntityDescription.insertNewObjectForEntityForName("ManagedUser", inManagedObjectContext: self.privateManagedObjectContext) as! ManagedUser
                managedOrder.id = userToCreate.id
                managedOrder.email = userToCreate.email
                managedOrder.firstName = userToCreate.firstName
                managedOrder.email = userToCreate.email
                try self.privateManagedObjectContext.save()
                completionHandler(error: nil)
            } catch {
                completionHandler(error: UsersStoreError.CannotCreate("Cannot create user with id \(userToCreate.id)"))
            }
        }
    }
    
    func fetchUser(id: String, completionHandler: (user: User?, error: UsersStoreError?) -> Void) {
        privateManagedObjectContext.performBlock {
            do {
                let fetchRequest = NSFetchRequest(entityName: "ManagedUser")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.privateManagedObjectContext.executeFetchRequest(fetchRequest) as! [ManagedUser]
                if let user = results.first?.toUser() {
                    completionHandler(user: user, error: nil)
                } else {
                    completionHandler(user: nil, error: UsersStoreError.CannotFetch("Cannot fetch user with id \(id)"))
                }
            } catch {
                completionHandler(user: nil, error: UsersStoreError.CannotFetch("Cannot fetch user with id \(id)"))
            }
        }
    }
    
    /*func createUser(userToCreate: User, completionHandler: UsersStoreCreateUserCompletionHandler) {
        privateManagedObjectContext.performBlock {
            do {
                let managedOrder = NSEntityDescription.insertNewObjectForEntityForName("ManagedUser", inManagedObjectContext: self.privateManagedObjectContext) as! ManagedUser
                managedOrder.id = userToCreate.id
                managedOrder.email = userToCreate.email
                managedOrder.firstName = userToCreate.firstName
                managedOrder.email = userToCreate.email
                try self.privateManagedObjectContext.save()
                completionHandler(result: UsersStoreResult.Success(result: ()))
            } catch {
                let error = UsersStoreError.CannotCreate("Cannot create user with id \(userToCreate.id)")
                completionHandler(result: UsersStoreResult.Failure(error: error))
            }
        }
    }*/
}