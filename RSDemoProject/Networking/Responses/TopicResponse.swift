//
//  BaseResponse.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct TopicResponse: Codable {
  var topic: Topic
  
  private enum CodingKeys: String, CodingKey {
    case topic
  }
}
