//
//  Conversation.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/10/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Conversation: Codable {
  var id: Int
  var topicIcon: String
  var lastMessage: String
  var unreadMessages: Int
  var user: User
  
  private enum CodingKeys: String, CodingKey {
    case id = "match_id"
    case topicIcon = "topic_icon"
    case lastMessage = "last_message"
    case unreadMessages = "unread_message"
    case user
  }
}
