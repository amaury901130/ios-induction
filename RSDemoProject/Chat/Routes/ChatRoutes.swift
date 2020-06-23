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
  case conversations
  
  var screen: UIViewController {
    switch self {
    case .chatModal(let conversation):
      guard let chatModal = R.storyboard.main.chatModalViewController() else {
        return UIViewController()
      }
      chatModal.viewModel = ChatModalViewModel(conversation: conversation)
      return chatModal
    case .conversations:
      guard let conversation = R.storyboard.main.conversationsViewController() else {
        return UIViewController()
      }
      conversation.viewModel = ConversationsViewModel()
      return conversation
    }
  }
}
