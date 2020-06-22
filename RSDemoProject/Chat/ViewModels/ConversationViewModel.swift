//
//  ConversationViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/22/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class ConversationViewModel {
  var conversation: Conversation?
  
  init(_ conversation: Conversation?) {
    self.conversation = conversation
  }

  func getUserAvatar() -> URL? {
    URL(string: conversation?.user?.avatar?.smallUrl ?? "")
  }
  
  func getUserFullName() -> String {
    conversation?.user?.fullName ?? ""
  }
  
  func getTopicIcon() -> URL? {
    URL(string: conversation?.topicIcon ?? "")
  }
  
  func latestMessage() -> String? {
    conversation?.lastMessage
  }
  
  func unreadMessage() -> Int {
    conversation?.unreadMessages ?? 0
  }
}
