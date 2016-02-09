//
//  GenericRepository.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

class GenericRepository: GenericRepositoryProtocol {
    let parseRepo = ParseRepository()
    
    func signUp(user: User, result: (Result<Void>) -> Void) {
        parseRepo.signUp(user, result: { (_result) in
            result(_result)
        })
    }
    
    func currentUser() -> User? {
        return parseRepo.currentUser()
    }
    
    /*func retrieveAccounts() -> [Account] {
        //TBD
        return nil
    }*/
}

protocol GenericRepositoryProtocol {
    func signUp(user: User, result: (Result<Void>) -> Void)
    func currentUser() -> User?
    //func retrieveAccounts() -> [Account]
}