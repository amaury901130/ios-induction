//
//  Conversation.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/4/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class MatchConversation: NSObject, Codable {
  var id: Int
  var topicId: Int
  var user: User?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case topicId = "topic_id"
  }
}
