//
//  BabyNamesDataStore.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

protocol BabyNamesDataStore {
    func fetchBabyNames(completionHandler: (babyNames: [BabyName], error: UsersStoreError?) -> Void)
}