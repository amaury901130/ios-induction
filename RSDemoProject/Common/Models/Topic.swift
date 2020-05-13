//
//  Topic.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/12/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Topic: Codable {
  var id: Int
  var label: String
  var icon: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case label
    case icon
  }
}
