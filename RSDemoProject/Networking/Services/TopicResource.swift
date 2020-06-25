//
//  TopicResource.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum TopicResource: TargetType {
  case getTopics
  
  var path: String {
    "/topics"
  }

  var method: Moya.Method {
    .get
  }
  
  var headers: [String: String]? {
    APIRequestHeaders.sessionHeaders
  }
  
  var task: Task {
    .requestPlain
  }
}
