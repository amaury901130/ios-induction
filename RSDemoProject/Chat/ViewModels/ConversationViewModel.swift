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
  var conversations: Results<Conversation>?
  
  var countConversations: Int {
    conversations?.count ?? 0
  }
  
  func getConversation(at index: Int) -> Conversation? {
    conversations?[index]
  }
  
  func getUserAvatar(at index: Int) -> URL? {
    URL(string: conversations?[index].user?.avatar?.smallUrl ?? "")
  }
  
  func getUserFullName(at index: Int) -> String {
    conversations?[index].user?.fullName ?? ""
  }
  
  func getTopicIcon(at index: Int) -> URL? {
    URL(string: conversations?[index].topicIcon ?? "")
  }
  
  func latestMessage(at index: Int) -> String? {
    conversations?[index].lastMessage
  }
  
  func unreadMessage(at index: Int) -> Int {
    conversations?[index].unreadMessages ?? 0
  }
}
