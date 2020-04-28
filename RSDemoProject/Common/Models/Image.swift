//
//  Avatar.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/27/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Image: Codable {
  var url: String?
  var normal: ImageVersion?
  var thumb: ImageVersion?
  
  private enum CodingKeys: String, CodingKey {
    case url
    case normal
    case thumb = "small_thumb"
  }
}

struct ImageVersion: Codable {
  var url: String?
  
  private enum CodingKeys: String, CodingKey {
     case url
   }
}
