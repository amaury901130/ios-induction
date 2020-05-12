//
//  HomeRoutes.swift
//  RSDemoProject
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum HomeRoutes: Route {
  case main
  case createTarget
  
  var screen: UIViewController {
    switch self {
    case .main:
      guard let main = R.storyboard.main.mainViewController() else {
        return UIViewController()
      }
      main.viewModel = MainViewModel()
      return main
    case .createTarget:
      guard let createTarget = R.storyboard.main.createTargetViewController() else {
        return UIViewController()
      }
      return createTarget
    }
  }
}
