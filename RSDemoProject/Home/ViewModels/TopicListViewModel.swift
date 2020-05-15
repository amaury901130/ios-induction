//
//  TopicListViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RxSwift

enum TopicListState {
  case didLoadTopics
  case didSelectTopic
}

protocol TopicListDelegate: class {
  func didUpdateTopicListState()
  func didUpdateState()
}

class TopicListViewModel {
  
  let topicRepo = TopicRepo.shared
  var topics: [Topic] = []
  
  var selectedTopic: Topic? {
    didSet {
      state = .didSelectTopic
    }
  }
  
  private let disposeBag = DisposeBag()
  
  weak var delegate: TopicListDelegate! {
    didSet {
      subscribe()
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
  
  func subscribe() {
    topicRepo.topics.asObservable().subscribe(onNext: { [weak self] topics in
      self?.networkState = .idle
      self?.topics = topics
      self?.state = .didLoadTopics
    }).disposed(by: disposeBag)
    
    topicRepo.error.asObservable().subscribe(onNext: { [weak self] error in
      guard let error = error else {
        return
      }
      
      self?.networkState = .error(error.localizedDescription)
    }).disposed(by: disposeBag)
  }
  
  func loadTopics() {
    networkState = .loading
    topicRepo.loadTopics()
  }
}
