//
//  ParseRepository.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation
import Parse

class ParseRepository : UserDataStore {
      
    func signUp(user: User, result: (Result<Void>) -> Void) {
        let parseUser = user.toParseUser()

        parseUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
            if ((error) != nil) {
                result(Result.Failure(error: "Failed signing up"))
            } else {
                result(Result.Success())
            }
        })
    }
    
    func currentUser() -> User? {
        let parseUser = PFUser.currentUser()
        if parseUser != nil {
            return User.fromParseUser(parseUser)
        }
        return nil
    }
}

extension User {
    static func fromParseUser(object: PFUser?) -> User? {
        if object != nil {
            return User(id: object?.objectId, firstName:  object!["additional"] as? String, email: object?.email, password: "")
        }
        return nil
    }
    
    func toParseUser() -> PFUser {
        let user = PFUser()
        user["additional"] = firstName
        user.email = email
        user.password = password
        user.objectId = id
        return user
    }
}