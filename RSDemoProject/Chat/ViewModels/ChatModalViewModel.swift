//
//  ChatModalViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/4/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

protocol ChatModalDelegate: class {
  func didModalState()
}

enum ChatModalState {
  case conversationLoaded
  case none
}

class ChatModalViewModel {
  var conversation: MatchConversation!
  
  var state: ChatModalState = .none {
    didSet {
      delegate?.didModalState()
    }
  }
  
  weak var delegate: ChatModalDelegate? {
    didSet {
      state = .conversationLoaded
    }
  }
  
  required init(conversation: MatchConversation) {
    self.conversation = conversation
  }
  
  var userImageURL: URL? {
    URL(string: conversation.user?.avatar?.url ?? "")
  }
  
  var userName: String {
    conversation.user?.username ?? ""
  }
}
