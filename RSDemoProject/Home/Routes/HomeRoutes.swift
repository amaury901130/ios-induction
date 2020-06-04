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
  case topicSelection(_ delegate: SelectTopicDelegate?)
  case deleteTarget(_ target: Target)
  case deleteTargetConfirmation(_ target: Target, delegate: DeleteConfirmationDelegate)
  
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
      createTarget.viewModel = CreateTargetViewModel()
      return createTarget
    case .topicSelection(let delegate):
      guard let topicSelection = R.storyboard.main.topicListViewController() else {
        return UIViewController()
      }
      
      topicSelection.topicListDelegate = delegate
      topicSelection.viewModel = TopicListViewModel()
      return topicSelection
    case .deleteTarget(let target):
      guard let deleteTarget = R.storyboard.main.deleteTargetViewController() else {
        return UIViewController()
      }
      
      deleteTarget.viewModel = DeleteTargetViewModel(target: target)
      return deleteTarget
    case .deleteTargetConfirmation(let target, let delegate):
      guard
        let deleteTargetConfirmation = R.storyboard.main.deleteTargetConfirmationViewController()
      else {
        return UIViewController()
      }
      
      deleteTargetConfirmation.deleteTargetDelegate = delegate
      deleteTargetConfirmation.viewModel = DeleteTargetConfirmationViewModel(target)
      return deleteTargetConfirmation
    }
  }
}
