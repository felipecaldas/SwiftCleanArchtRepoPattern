//
//  RetrieveBabyNamesPresenter.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 7/02/2016.
//  Copyright (c) 2016 FunkApps FMC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol RetrieveBabyNamesPresenterInput
{
  func presentSomething(response: RetrieveBabyNamesResponse)
}

protocol RetrieveBabyNamesPresenterOutput: class
{
  func displaySomething(viewModel: RetrieveBabyNamesViewModel)
}

class RetrieveBabyNamesPresenter: RetrieveBabyNamesPresenterInput
{
  weak var output: RetrieveBabyNamesPresenterOutput!
  
  // MARK: Presentation logic
  
  func presentSomething(response: RetrieveBabyNamesResponse)
  {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller
    
    let viewModel = RetrieveBabyNamesViewModel()
    output.displaySomething(viewModel)
  }
}