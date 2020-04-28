//
//  HomeViewModel.swift
//  RSDemoProject
//
//  Created by German on 8/3/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
  func didUpdateHomeState()
  func didUpdateViewModelState()
}

enum HomeViewModelState: Equatable {
  case logOut
}

class HomeViewModel {
  
  weak var delegate: HomeViewModelDelegate?
  
  var userEmail: String?
  
  var state: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateViewModelState()
    }
  }
  
  var homeState: HomeViewModelState? {
    didSet {
      delegate?.didUpdateHomeState()
    }
  }
  
  func loadUserProfile() {
    state = .loading
    UserService.sharedInstance.getMyProfile({ [weak self] user in
      self?.userEmail = user.email
      self?.state = .idle
    }, failure: { [weak self] error in
      self?.state = .error(error.localizedDescription)
    })
  }
  
  func logoutUser() {
    state = .loading
    UserService.sharedInstance.logout({ [weak self] in
      AnalyticsManager.shared.reset()
      self?.homeState = .logOut
    }, failure: { [weak self] error in
      self?.state = .error(error.localizedDescription)
    })
  }
}
