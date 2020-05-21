//
//  Target.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/19/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import MapKit

class Target: Codable {
  var id: Int
  var title: String
  var latitude: Double
  var longitude: Double
  var radius: Int
  var topicId: Int
  
  var location: CLLocation
  var topic: Topic?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case latitude = "lat"
    case longitude = "lng"
    case radius
    case topicId = "topic_id"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    latitude = try container.decode(Double.self, forKey: .latitude)
    longitude = try container.decode(Double.self, forKey: .longitude)
    radius = try container.decode(Int.self, forKey: .radius)
    topicId = try container.decode(Int.self, forKey: .topicId)
    
    location = CLLocation(latitude: latitude, longitude: longitude)
    topic = TopicDataManager.topics.first { $0.id == topicId }
  }
}
