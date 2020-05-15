//
//  TopicRepo.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RxRelay

class TopicRepo {
  
  static let shared = TopicRepo()
  let topics: BehaviorRelay<[Topic]> = BehaviorRelay(value: [])
  let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
  
  func loadTopics() {
    guard topics.value.isEmpty else {
      return
    }
    
    if let savedTopics = TopicDataManager.topics {
      topics.accept(savedTopics)
    }
    
    TopicService.shared.getTopics(
      success: { [weak self] topics in
        let resultTopics = topics.map { $0.topic }
        
        TopicDataManager.topics = resultTopics
        self?.topics.accept(resultTopics)
      },
      failure: { [weak self] error in
        self?.error.accept(error)
      }
    )
  }
}
