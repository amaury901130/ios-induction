//
//  ChatRoutes.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/4/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum ChatRoutes: Route {
  case chatModal(conversation: MatchConversation)
  
  var screen: UIViewController {
    switch self {
    case .chatModal(let conversation):
      guard let chatModal = R.storyboard.main.chatModalViewController() else {
        return UIViewController()
      }
      chatModal.viewModel = ChatModalViewModel(conversation: conversation)
      return chatModal
    }
  }
}
