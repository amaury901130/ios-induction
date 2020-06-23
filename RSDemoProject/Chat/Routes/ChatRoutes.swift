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
  case chat(_ conversation: Conversation)
  
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
    case .chat(let conversation):
      guard let chat = R.storyboard.main.chatViewController() else {
        return UIViewController()
      }
      chat.viewModel = ChatViewModel(conversation)
      return chat
    }
  }
}
