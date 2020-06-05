//
//  ChatModalViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/4/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class ChatModalViewModel {
  var conversation: MatchConversation!

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
