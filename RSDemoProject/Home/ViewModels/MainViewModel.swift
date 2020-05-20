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
  case didUpdateLocation
  case didLoadTargets
  case didTargetSelect
}

protocol MainViewModelDelegate: class {
  func didUpdateState()
  func didUpdateMainState()
}

class MainViewModel {
  
  private var locationManager = LocationManager.shared
  private var page = 1
  var defaultMapRadius = 200
  var userTargets: [Target]?
  var selectedTarget: Target? {
    didSet {
      state = .didTargetSelect
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
  
  private func loadTopics() {
    networkState = .loading
    
    TopicService.shared.getTopics(
      success: { [weak self] topics in
        let resultTopics = topics.map { $0.topic }
        TopicDataManager.topics = resultTopics
        self?.loadTargets()
        self?.networkState = .idle
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
  
  private func loadTargets() {
    networkState = .loading
    TargetService.shared.getTargets(
      page: page,
      success: { [weak self] targets in
        self?.page += 1
        self?.userTargets = targets
        self?.state = .didLoadTargets
        self?.networkState = .idle
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
  
  func requestCurrentLocation() {
    locationManager.requestCurrentLocation(listener: { [weak self] in
      self?.state = .didUpdateLocation
    })
  }
}
