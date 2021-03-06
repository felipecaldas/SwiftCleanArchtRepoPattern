//
//  ShowBabyNamesViewController.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright (c) 2016 FunkApps FMC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ShowBabyNamesViewControllerInput
{
  func displaySomething(viewModel: ShowBabyNamesViewModel)
}

protocol ShowBabyNamesViewControllerOutput
{
  func doSomething(request: ShowBabyNamesRequest)
}

class ShowBabyNamesViewController: UIViewController, ShowBabyNamesViewControllerInput
{
  var output: ShowBabyNamesViewControllerOutput!
  var router: ShowBabyNamesRouter!
  
    @IBOutlet weak var babyNamesLabel: UILabel!
  // MARK: Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    ShowBabyNamesConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomethingOnLoad()
  }
  
  // MARK: Event handling
  
  func doSomethingOnLoad()
  {
    // NOTE: Ask the Interactor to do some work
    
    let request = ShowBabyNamesRequest()
    output.doSomething(request)
  }
  
  // MARK: Display logic
  
  func displaySomething(viewModel: ShowBabyNamesViewModel)
  {
    if viewModel.nameList != nil{
        //babyNamesLabel.text = viewModel.nameList
        
        //The above line alone throws error. It needs to be run in UI thread. error is:
        //This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release.
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.babyNamesLabel.text = viewModel.nameList
            }
        }
    }
  }
}
