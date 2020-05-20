//
//  TopicDataManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class TopicDataManager: NSObject {
  
  static var topics: [Topic] {
    get {
      let defaults = UserDefaults.standard
      if
        let data = defaults.data(forKey: "RSDemoProject-topics"),
        let topics = try? JSONDecoder().decode([Topic].self, from: data)
      {
        return topics
      }
      return []
    }
    
    set {
      let topics = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(topics, forKey: "RSDemoProject-topics")
    }
  }
}
