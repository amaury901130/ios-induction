//
//  Avatar.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/27/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class Image: Object, Codable {
  @objc dynamic var url: String?
  @objc dynamic var normal: ImageVersion?
  @objc dynamic var thumb: ImageVersion?
  @objc dynamic var normalUrl: String?
  @objc dynamic var smallUrl: String?
  @objc dynamic var originalUrl: String?
  
  private enum CodingKeys: String, CodingKey {
    case url
    case normal
    case thumb = "small_thumb"
    case normalUrl = "normal_url"
    case smallUrl = "small_thumb_url"
    case originalUrl = "original_url"
  }
}

class ImageVersion: Object, Codable {
  @objc dynamic var url: String?
  
  private enum CodingKeys: String, CodingKey {
    case url
  }
}
