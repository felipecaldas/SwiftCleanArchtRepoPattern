//
//  ManagedBabyName.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import CoreData


class ManagedBabyName: NSManagedObject {

    func toBabyName() -> BabyName{
        return BabyName(id: id, name: name, meanings: meanings)
    }

}
