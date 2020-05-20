//
//  TargetResponse.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/20/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct TargetResponse: Codable {
  var target: Target
  
  private enum CodingKeys: String, CodingKey {
    case target
  }
}
