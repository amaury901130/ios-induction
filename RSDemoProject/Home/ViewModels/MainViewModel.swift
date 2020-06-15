//
//  MainViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import CoreLocation

enum MainViewModelState {
  case locationUpdated
  case targetsLoaded
  case targetSelected
  case newMatchCreated
  case conversationsLoaded
}

protocol MainViewModelDelegate: class {
  func didUpdateState()
  func didUpdateMainState()
}

class MainViewModel {
  
  private var locationManager = LocationManager.shared
  private var page = 1
  var defaultMapRadius = 200
  var userTargets: [Target] = []
  var conversations: [Conversation] = []
  
  var createdTarget: Target? {
    didSet {
      loadTargets()
    }
  }
  
  var unreadMessages: Int {
    conversations.reduce(0) { $0 + $1.unreadMessages }
  }
  
  var userAvatar: String? {
    UserDataManager.currentUser?.avatar?.thumb?.url
  }
  
  var selectedTarget: Target? {
    didSet {
      state = .targetSelected
    }
  }
  
  var currentLocation: CLLocation? {
    locationManager.currentLocation
  }
  
  weak var delegate: MainViewModelDelegate? {
    didSet {
      loadTopics()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var state: MainViewModelState! {
    didSet {
      delegate?.didUpdateMainState()
    }
  }
  
  var newTargetMatch: TargetMatch? {
    didSet {
      createdTarget = newTargetMatch?.target
      matchConversation = newTargetMatch?.matchedConversation
      matchConversation?.user = newTargetMatch?.matchedUser
      state = .newMatchCreated
    }
  }
  
  var matchConversation: MatchConversation?
  
  private func loadTopics() {
    networkState = .loading
    
    TopicService.shared.getTopics(
      success: { [weak self] topics in
        let resultTopics = topics.map { $0.topic }
        TopicDataManager.topics = resultTopics
        self?.networkState = .idle
        self?.loadTargets()
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
  
  private func proccessConversations(_ conversations: [Conversation]) {
    self.conversations = conversations
    state = .conversationsLoaded
  }
  
  private func loadConversations() {
    ConversationService.shared.getConversations(
      { [weak self] conversations in
        self?.networkState = .idle
        self?.proccessConversations(conversations)
      }, failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
    })
  }
  
  private func loadTargets() {
    networkState = .loading
    TargetService.shared.getTargets(
      success: { [weak self] targets in
        self?.page += 1
        self?.userTargets = targets
        self?.state = .targetsLoaded
        self?.loadConversations()
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
  
  func requestCurrentLocation() {
    locationManager.requestCurrentLocation(listener: { [weak self] in
      self?.state = .locationUpdated
    })
  }
}
