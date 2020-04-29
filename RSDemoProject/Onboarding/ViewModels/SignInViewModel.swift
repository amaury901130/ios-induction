//
//  SignInViewModel.swift
//  RSDemoProject
//
//  Created by German on 8/3/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import FBSDKCoreKit

protocol SignInViewModelDelegate: class {
  func didUpdateSignInState()
  func didUpdateState()
}

enum SignInViewModelState: Equatable {
  case signedIn
}

class SignInViewModelWithCredentials {
  
  var state: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }

  var signInState: SignInViewModelState? {
    didSet {
      delegate?.didUpdateSignInState()
    }
  }
  
  weak var delegate: SignInViewModelDelegate?
  
  func facebookLoginRequestSucceded() {
    guard let token = AccessToken.current else {
      return
    }
    
    UserService.sharedInstance.loginWithFacebook(
      token: token.tokenString,
      success: { [weak self] in
        self?.signInState = .signedIn
      },
      failure: { [weak self] error in
        self?.state = .error(error.localizedDescription)
    })
  }
  
  func login(email: String, password: String) {
    state = .loading
    UserService.sharedInstance
      .login(email,
             password: password,
             success: { [weak self] in
              guard let self = self else { return }
              self.signInState = .signedIn
              AnalyticsManager.shared.identifyUser(with: email)
              AnalyticsManager.shared.log(event: Event.login)
        },
             failure: { [weak self] error in
              self?.state = .error(error.localizedDescription)
      })
  }
}
