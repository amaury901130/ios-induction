//
//  TopicListViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum TopicListState {
  case didLoadTopics
  case didSelectTopic
}

protocol TopicListDelegate: class {
  func didUpdateTopicListState()
  func didUpdateState()
}

class TopicListViewModel {
  
  var topics: [Topic] = []
  
  var selectedTopic: Topic! {
    didSet {
      state = .didSelectTopic
    }
  }
  
  weak var delegate: TopicListDelegate! {
    didSet {
      loadTopics()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var state: TopicListState! {
    didSet {
      delegate?.didUpdateTopicListState()
    }
  }
  
  func selectTopic(_ index: Int) {
    selectedTopic = topics[index]
  }
  
  func countTopics() -> Int {
    topics.count
  }
  
  func getTopic(_ index: Int) -> Topic {
    topics[index]
  }
  
  func loadTopics() {
    topics = TopicDataManager.topics
    
    if !topics.isEmpty {
      state = .didLoadTopics
    }
    
    networkState = .loading
    
    TopicService.shared.getTopics(
      success: { [weak self] topics in
        let resultTopics = topics.map { $0.topic }
        
        guard TopicDataManager.topics != resultTopics else {
          return
        }
        
        TopicDataManager.topics = resultTopics
        self?.networkState = .idle
        self?.topics = resultTopics
        self?.state = .didLoadTopics
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
}
