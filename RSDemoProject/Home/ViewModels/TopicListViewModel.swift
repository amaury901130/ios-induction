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
}

protocol TopicListDelegate: class {
  func didUpdateTopicListState()
  func didUpdateState()
}

class TopicListViewModel {
  
  let topicRepo = TopicRepo.shared
  var topics: [Topic]!
  private let disposeBag = DisposeBag()
  
  var delegate: TopicListDelegate! {
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
  
  var state: TopicListState? {
    didSet {
      delegate?.didUpdateTopicListState()
    }
  }
  
  func subscribe() {
    topicRepo.topics.asObservable().subscribe(onNext: { [unowned self] topics in
      self.networkState = .idle
      self.topics = topics
      self.state = .didLoadTopics
    }).disposed(by: disposeBag)
    
    topicRepo.error.asObservable().subscribe(onNext: { [unowned self] error in
      guard let error = error else {
        return
      }
      self.networkState = .error(error.localizedDescription)
    }).disposed(by: disposeBag)
  }
  
  func loadTopics() {
    networkState = .loading
    topicRepo.loadTopics()
  }
}
