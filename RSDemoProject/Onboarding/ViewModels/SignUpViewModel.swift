//
//  SignUpViewModel.swift
//  RSDemoProject
//
//  Created by German on 8/21/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewModelDelegate: class {
  func formDidChange()
  func didUpdateState()
}

class SignUpViewModelWithEmail {
  
  var state: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  weak var delegate: SignUpViewModelDelegate?
  
  var email = "" {
    didSet {
      delegate?.formDidChange()
    }
  }
  
  var name = "" {
    didSet {
      delegate?.formDidChange()
    }
  }
  
  var password = "" {
    didSet {
      delegate?.formDidChange()
    }
  }
  
  var passwordConfirmation = "" {
    didSet {
      delegate?.formDidChange()
    }
  }
  
  var hasValidData: Bool {
    return
      email.isEmailFormatted() && !password.isEmpty && password == passwordConfirmation
  }
  
  func signIn() {
    AppNavigator.shared.navigate(to: OnboardingRoutes.signIn, with: .changeRoot)
  }
  
  func signup(name: String, email: String, password: String) {
    self.name = name
    self.email = email
    self.password = password
    signup()
  }
  
  func signup() {
    state = .loading
    UserService.sharedInstance.signup(
      email, name: name, password: password, avatar64: UIImage.random(),
      success: { [weak self] in
        guard let self = self else { return }
        self.state = .idle
        AnalyticsManager.shared.identifyUser(with: self.email)
        AnalyticsManager.shared.log(event: Event.registerSuccess(email: self.email))
        AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
      },
      failure: { [weak self] error in
        if let apiError = error as? APIError {
          self?.state = .error(apiError.firstError ?? "") // show the first error
        } else {
          self?.state = .error(error.localizedDescription)
        }
    })
  }
}
