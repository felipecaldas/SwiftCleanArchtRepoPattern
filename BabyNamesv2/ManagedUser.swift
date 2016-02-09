//
//  ManagedUser.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import CoreData


class ManagedUser: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func toUser() -> User
    {
        return User(id: id, firstName:  firstName, email: email, password: password)
    }

}
