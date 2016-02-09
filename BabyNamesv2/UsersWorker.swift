//
//  UsersWorker.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import Foundation

class UsersWorker
{
    var usersStore: UsersStoreProtocol
    
    init(usersStore: UsersStoreProtocol)
    {
        self.usersStore = usersStore
    }
    
    /*func fetchUsers(completionHandler: (users: [User]) -> Void)
    {
        usersStore.fetchUsers{ (users: () throws -> [User]) -> Void in
            do {
                let users = try users()
                completionHandler(users: users)
            } catch {
                completionHandler(users: [])
            }
        }
    }*/
    
    func createUser(userToCreate: User, completionHandler: (error: UsersStoreError?) -> Void) {
        print("UsersWorker here")
        usersStore.createUser(userToCreate) { (error) in
            if error != nil {
                completionHandler(error: error)
            } else {
                completionHandler(error: nil)
            }
        }
    }
    
    func fetchUser(id: String, completionHandler: (user: User?, error: UsersStoreError?) -> Void) {
        usersStore.fetchUser(id, completionHandler: {(user, error) in
            if error != nil {
                completionHandler(user: nil, error: error)
            } else {
                completionHandler(user: user, error: nil)
            }
        })
    }
}

// MARK: - Users store API

protocol UsersStoreProtocol
{
    // MARK: CRUD operations - Optional error
    
    //func fetchUsers(completionHandler: (users: [User], error: UsersStoreError?) -> Void)
    func fetchUser(id: String, completionHandler: (user: User?, error: UsersStoreError?) -> Void)
    func createUser(userToCreate: User, completionHandler: (error: UsersStoreError?) -> Void)
    //func updateOrder(orderToUpdate: Order, completionHandler: (error: OrdersStoreError?) -> Void)
    //func deleteOrder(id: String, completionHandler: (error: OrdersStoreError?) -> Void)
    
    // MARK: CRUD operations - Generic enum result type
    
    //func fetchUsers(completionHandler: UsersStoreFetchUsersCompletionHandler)
    //func fetchUser(id: String, completionHandler: UsersStoreFetchUserCompletionHandler)
    //func createUser(userToCreate: User, completionHandler: UsersStoreCreateUserCompletionHandler)
    //func updateOrder(orderToUpdate: Order, completionHandler: OrdersStoreUpdateOrderCompletionHandler)
    //func deleteOrder(id: String, completionHandler: OrdersStoreDeleteOrderCompletionHandler)
    
    // MARK: CRUD operations - Inner closure
    
    //func fetchUsers(completionHandler: (users: () throws -> [User]) -> Void)
    //func fetchUser(id: String, completionHandler: (user: () throws -> User?) -> Void)
    //func createUser(userToCreate: User, completionHandler: (done: () throws -> Void) -> Void)
    //func updateOrder(orderToUpdate: Order, completionHandler: (done: () throws -> Void) -> Void)
    //func deleteOrder(id: String, completionHandler: (done: () throws -> Void) -> Void)
}

// MARK: - Orders store CRUD operation results

typealias UsersStoreFetchUsersCompletionHandler = (result: UsersStoreResult<[User]>) -> Void
typealias UsersStoreFetchUserCompletionHandler = (result: UsersStoreResult<User>) -> Void
typealias UsersStoreCreateUserCompletionHandler = (result: UsersStoreResult<Void>) -> Void
//typealias OrdersStoreUpdateOrderCompletionHandler = (result: UsersStoreResult<Void>) -> Void
//typealias OrdersStoreDeleteOrderCompletionHandler = (result: UsersStoreResult<Void>) -> Void

enum UsersStoreResult<U>
{
    case Success(result: U)
    case Failure(error: UsersStoreError)
}

// MARK: - Users store CRUD operation errors

enum UsersStoreError: Equatable, ErrorType
{
    case CannotFetch(String)
    case CannotCreate(String)
    //case CannotUpdate(String)
    //case CannotDelete(String)
}

func ==(lhs: UsersStoreError, rhs: UsersStoreError) -> Bool
{
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
    //case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
    //case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
    default: return false
    }
}