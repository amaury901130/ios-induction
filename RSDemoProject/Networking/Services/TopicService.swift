//
//  TopicService.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

class TopicService: BaseApiService<TopicResource> {
  static let shared = TopicService()
  
  public func getTopics(
    success: @escaping (_ topics: [TopicResponse]) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: .getTopics,
            at: "topics",
            onSuccess: { (result: [TopicResponse], _) -> Void in
              success(result)
    }, onFailure: { error, _ in
      failure(error)
    })
  }
}
