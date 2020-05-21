//
//  TargetResource.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/18/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum TargetResource: TargetType {
  case createTarget(
    title: String,
    area: Int,
    topic: Topic,
    latitude: Double,
    longitude: Double
  )
  case getTargets
  case destroyTarget(_ id: Int)
  
  var path: String {
    let targetBasePath = "/targets"
    
    switch self {
    case .createTarget, .getTargets:
      return targetBasePath
    case .destroyTarget(let id):
      return "\(targetBasePath)/\(id)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getTargets:
      return .get
    case .createTarget:
      return .post
    case .destroyTarget:
      return .delete
    }
  }
  
  var headers: [String: String]? {
    getHeaders()
  }
  
  var task: Task {
    switch self {
    case .createTarget(
      let title,
      let area,
      let topic,
      let latitude,
      let longitude
    ):
      let parameters = createTargetParameters(
        title: title,
        area: area,
        topic: topic,
        latitude: latitude,
        longitude: longitude
      )
      
      return requestParameters(parameters: parameters)
    default:
      return .requestPlain
    }
  }

  private func createTargetParameters(
    title: String,
    area: Int,
    topic: Topic,
    latitude: Double,
    longitude: Double
  ) -> [String: Any] {
    [
      "target": [
        "title": title,
        "radius": area,
        "topic_id": topic.id,
        "lat": latitude,
        "lng": longitude
      ]
    ]
  }
}
