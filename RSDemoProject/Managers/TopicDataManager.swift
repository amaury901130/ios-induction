//
//  TopicDataManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class TopicDataManager: NSObject {
  
  static var topics: [Topic]? {
    get {
      let defaults = UserDefaults.standard
      if
        let data = defaults.data(forKey: "RSDemoProject-topics"),
        let user = try? JSONDecoder().decode([Topic].self, from: data)
      {
        return user
      }
      return nil
    }
    
    set {
      let user = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(user, forKey: "RSDemoProject-topics")
    }
  }
}
