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
  var normalUrl: String?
  var smallUrl: String?
  var originalUrl: String?
  
  private enum CodingKeys: String, CodingKey {
    case url
    case normal
    case thumb = "small_thumb"
    case normalUrl = "normal_url"
    case smallUrl = "small_thumb_url"
    case originalUrl = "original_url"
  }
}

struct ImageVersion: Codable {
  var url: String?
  
  private enum CodingKeys: String, CodingKey {
     case url
   }
}
