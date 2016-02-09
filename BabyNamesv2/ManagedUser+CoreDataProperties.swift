//
//  ManagedUser+CoreDataProperties.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ManagedUser {

    @NSManaged var id: String?
    @NSManaged var email: String?
    @NSManaged var firstName: String?
    @NSManaged var password: String?

}
