//
//  CreateTargetVIewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/12/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import CoreLocation

enum CreateTargetViewModelState {
  case targetCreated(_ response: CreateTargetResponse)
  case didSelectTopic
  case errorTitle(_ error: Bool)
  case errorArea(_ error: Bool)
}

protocol CreateTargetDelegate: class {
  func didUpdateCreateTargetState()
  func didUpdateState()
}

class CreateTargetViewModel {
  
  let defaultTargetArea = 200
  let areaUnit = "m"

  private var targetLocation: CLLocation? {
    LocationManager.shared.currentLocation
  }
  
  weak var delegate: CreateTargetDelegate?
  
  var selectedTopic: Topic? {
    didSet {
      state = .didSelectTopic
    }
  }
  
  var topicImage: String? {
    selectedTopic?.icon
  }
  
  var topicTitle: String? {
    selectedTopic?.label.uppercased()
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }

  var state: CreateTargetViewModelState! {
    didSet {
      delegate?.didUpdateCreateTargetState()
    }
  }
  
  var targetArea: String = "200 m" {
    didSet {
      state = .errorArea(targetArea.isEmpty)
    }
  }
  
  var targetTitle: String = "" {
    didSet {
      state = .errorTitle(targetTitle.isEmpty)
    }
  }
  
  func createTarget() {
    guard isTargetValid(), let topic = selectedTopic else {
      return
    }
    
    TargetService.shared.createTarget(
      title: targetTitle,
      area: Int(targetArea) ?? defaultTargetArea,
      topic: topic,
      latitude: LocationManager.shared.currentLocation.coordinate.latitude,
      longitude: LocationManager.shared.currentLocation.coordinate.longitude,
      success: { [weak self] response in
        self?.networkState = .idle
        self?.state = .targetCreated(response)
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      })
  }
  
  func isTargetValid() -> Bool {
    var error = false
    
    if targetArea.isEmpty {
      state = .errorArea(true)
      error = true
    }
    
    if targetTitle.isEmpty {
      state = .errorTitle(true)
      error = true
    }
    
    return !error && selectedTopic != nil
  }
}

extension CreateTargetViewModel: TopicListResponseDelegate {
  func didSelectTopic(_ topic: Topic) {
    selectedTopic = topic
  }
}
