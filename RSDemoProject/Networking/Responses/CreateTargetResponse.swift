//
//  CreateTargetResponse.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/18/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class CreateTargetResponse: NSObject, Codable {
  var target: Target
  var matchedConversation: MatchConversation?
  var matchedUser: User?

  private enum CodingKeys: String, CodingKey {
    case target
    case matchedConversation = "match_conversation"
    case matchedUser = "matched_user"
  }
}
