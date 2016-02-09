//
//  BabyNameRepository.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

class BabyNameRepository: BabyNamesDataStore {
    let coreDataStore = BabyNamesCoreDataStore()
    let apiDataStore = BabyNamesAPI()
    
    func fetchBabyNames(completionHandler: (babyNames: [BabyName], error: UsersStoreError?) -> Void) {
        coreDataStore.fetchBabyNames({ (babyNames, error) in
            if (error != nil || babyNames.count <= 0) {
                self.apiDataStore.fetchBabyNames({ (babyNamesAPI, errorAPI) in
                    if errorAPI != nil {
                        completionHandler(babyNames: [], error: errorAPI)
                    } else {
                        //TODO insert this data in CoreData to avoid going to API, since this data is immutable
                        //coreDataStore.insertNewData(babyNamesAPI)
                        completionHandler(babyNames: babyNamesAPI, error: nil)
                    }
                })
            } else {
                completionHandler(babyNames: babyNames, error: error)
            }
        })
    }
}