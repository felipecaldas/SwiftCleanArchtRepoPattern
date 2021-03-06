//
//  CreateUserConfigurator.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright (c) 2016 FunkApps FMC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CreateUserViewController: CreateUserPresenterOutput
{
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    router.passDataToNextScene(segue)
  }
}

extension CreateUserInteractor: CreateUserViewControllerOutput
{

}

extension CreateUserPresenter: CreateUserInteractorOutput
{
}

class CreateUserConfigurator
{
  // MARK: Object lifecycle
  
  class var sharedInstance: CreateUserConfigurator
  {
    struct Static {
      static var instance: CreateUserConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = CreateUserConfigurator()
    }
    
    return Static.instance!
  }
  
  // MARK: Configuration
  
  func configure(viewController: CreateUserViewController)
  {
    let router = CreateUserRouter()
    router.viewController = viewController
    
    let presenter = CreateUserPresenter()
    presenter.output = viewController
    
    let interactor = CreateUserInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
