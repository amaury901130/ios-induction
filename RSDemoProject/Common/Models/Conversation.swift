//
//  Conversation.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/10/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class Conversation: Object, Codable {
  @objc dynamic var id: Int
  @objc dynamic var topicIcon: String
  @objc dynamic var lastMessage: String?
  @objc dynamic var unreadMessages: Int = 0
  @objc dynamic var user: User?
  
  private enum CodingKeys: String, CodingKey {
    case id = "match_id"
    case topicIcon = "topic_icon"
    case lastMessage = "last_message"
    case unreadMessages = "unread_messages"
    case user
  }
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
