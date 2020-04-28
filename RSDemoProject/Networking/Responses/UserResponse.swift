//
//  DataResponse.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/28/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
  var data: User
  
  private enum CodingKeys: String, CodingKey {
    case data
  }
}
