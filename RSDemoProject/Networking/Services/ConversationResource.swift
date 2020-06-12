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
    let conversatioBaseUrl = "match_conversations"
    switch self {
    case .getConversations:
      return conversatioBaseUrl
    case .getMessages(let conversationId, let page):
      return "\(conversatioBaseUrl)/\(conversationId)/messages?page=\(page)"
    }
  }
  
  var headers: [String: String]? {
    getHeaders()
  }
  
  var method: Moya.Method {
    .get
  }
  
  var task: Task {
    return .requestPlain
  }
}
