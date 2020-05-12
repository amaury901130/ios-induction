//
//  HomeRoutes.swift
//  RSDemoProject
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum HomeRoutes: Route {
  case main
  case createTarget(_ location: CLLocation)
  
  var screen: UIViewController {
    switch self {
    case .main:
      guard let main = R.storyboard.main.mainViewController() else {
        return UIViewController()
      }
      main.viewModel = MainViewModel()
      return main
    case .createTarget(let location):
      guard let createTarget = R.storyboard.main.createTargetViewController() else {
        return UIViewController()
      }
      createTarget.viewModel = CreateTargetViewModel(location)
      
      return createTarget
    }
  }
}
