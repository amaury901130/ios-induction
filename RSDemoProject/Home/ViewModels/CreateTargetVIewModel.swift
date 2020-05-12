//
//  CreateTargetVIewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/12/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import CoreLocation

enum CreateTargetViewModelState: Equatable {
  case targetCreated
}

protocol CreateTargetDelegate: class {
  func didUpdateCreateTargetState()
  func didUpdateState()
}

class CreateTargetViewModel {
  
  var targetLocation: CLLocation?
  weak var delegate: CreateTargetDelegate?
  
  init(_ location: CLLocation) {
    targetLocation = location
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }

  var state: CreateTargetViewModelState? {
    didSet {
      delegate?.didUpdateCreateTargetState()
    }
  }
  
}
