//
//  BabyNameCoreDataStore.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import CoreData

class BabyNamesCoreDataStore : BabyNamesDataStore{
    
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
    
    func fetchBabyNames(completionHandler: (babyNames: [BabyName], error: UsersStoreError?) -> Void) {
        privateManagedObjectContext.performBlock {
            do {
                let fetchRequest = NSFetchRequest(entityName: "ManagedBabyName")
                let results = try self.privateManagedObjectContext.executeFetchRequest(fetchRequest) as! [ManagedBabyName]
                let result = results.map { $0.toBabyName() }
                completionHandler(babyNames: result, error: nil)
            } catch {
                completionHandler(babyNames: [], error: UsersStoreError.CannotFetch("Cannot fetch baby names"))
            }
        }

    }
}