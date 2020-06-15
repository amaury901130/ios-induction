//
//  ConversationService.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/10/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

class ConversationService: BaseApiService<ConversationResource>  {
  static let shared = ConversationService()
  
  func getConversations(
    _ success: @escaping (_ response: [Conversation]) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: .getConversations,
      onSuccess: { (result: [Conversation], _) -> Void in
        success(result)
      },
      onFailure: { error, _ in failure(error) }
    )
  }
  
  func getMessages(
    conversationId: Int,
    page: Int,
    success: @escaping (_ response: [Message]) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: .getConversations,
      at: "messages",
      onSuccess: { (result: [Message], _) -> Void in
        success(result)
      },
      onFailure: { error, _ in failure(error) }
    )
  }
}
