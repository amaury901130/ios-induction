//
//  Message.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/10/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Message: Codable {
  var id: Int
  var content: String
  var date: Date
  var user: User
  
  private enum CodingKeys: String, CodingKey {
    case id
    case content
    case date
    case user
  }
}
