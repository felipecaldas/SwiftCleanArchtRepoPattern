//
//  UserDataStore.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

protocol UserDataStore {
    func signUp(user: User, result: (Result<Void>) -> Void)
    func currentUser() -> User?
}

enum Result<U> {
    case Success()
    case Failure(error: String)
}