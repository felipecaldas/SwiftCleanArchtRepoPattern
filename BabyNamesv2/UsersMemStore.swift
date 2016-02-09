//
//  UsersMemStore.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

class UsersMemStore: UsersStoreProtocol {
    var user = User()
    var usersCoreDataStore = UsersCoreDataStore()
    
    func createUser(userToCreate: User, completionHandler: (error: UsersStoreError?) -> Void) {
        usersCoreDataStore.createUser(userToCreate, completionHandler: { (error) in
            completionHandler(error: error)
        })
    }
    
    func fetchUser(id: String, completionHandler: (user: User?, error: UsersStoreError?) -> Void) {
        usersCoreDataStore.fetchUser(id, completionHandler: { (user, error) in
            completionHandler(user: user, error: error)
        })
    }
}