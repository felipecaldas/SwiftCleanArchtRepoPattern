//
//  BabyNamesAPI.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import SwiftyJSON

class BabyNamesAPI : BabyNamesDataStore{
    
    func fetchBabyNames(completionHandler: (babyNames: [BabyName], error: UsersStoreError?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://funkapps.mobi/backend/babynames/query_names.php")!)
        HttpUtils.httpGet(request) {
            (data, error) -> Void in
            if error != nil {
                completionHandler(babyNames: [], error: UsersStoreError.CannotFetch("Could not fetch from API"))
            } else {
                let json = JSON(data: data)
                var result = [BabyName]()
                
                for (_, subJson): (String, JSON) in json {
                    let _id = subJson["id"].string
                    let _name = subJson["name"].string
                    let _meaning = subJson["meaning"].string
                    let temp = BabyName(id: _id, name: _name, meanings: _meaning)
                    result.append(temp)
                }
                completionHandler(babyNames: result, error: nil)
            }
        }
    }
}