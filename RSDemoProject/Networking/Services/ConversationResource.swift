//
//  ConversationResource.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/10/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum ConversationResource: TargetType {
  
  case getConversations
  case getMessages(conversationId: Int, page: Int = 1)
  
  var path: String {
    let conversationBaseUrl = "match_conversations"
    switch self {
    case .getConversations:
      return conversationBaseUrl
    case .getMessages(let conversationId, let page):
      return "\(conversationBaseUrl)/\(conversationId)/messages?page=\(page)"
    }
  }
  
  var headers: [String: String]? {
    APIRequestHeaders.sessionHeaders
  }
  
  var method: Moya.Method {
    .get
  }
  
  var task: Task {
    return .requestPlain
  }
}
