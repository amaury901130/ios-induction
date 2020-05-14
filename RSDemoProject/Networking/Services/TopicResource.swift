//
//  TopicResource.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum TopicResource: TargetType{
  case getTopics
  
  var path: String {
    let topicsBasePath = "/topics"
    switch self {
    case .getTopics:
      return "\(topicsBasePath)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getTopics:
      return .get
    }
  }
  
  var headers: [String: String]? {
    getHeaders()
  }
  
  var task: Task {
    switch self {
    case .getTopics:
      return .requestPlain
    }
  }
}
