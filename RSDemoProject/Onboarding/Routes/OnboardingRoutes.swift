//
//  OnboardingRoutes.swift
//  RSDemoProject
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingRoutes: Route {
  case signIn
  case signUp

  var screen: UIViewController {
    switch self {
    case .signIn:
      return buildSignInViewController()
    case .signUp:
      return buildSignUpViewController()
    }
  }

  private func buildSignInViewController() -> UIViewController {
    guard let signIn = R.storyboard.main.signInViewController() else {
      return UIViewController()
    }
    signIn.viewModel = SignInViewModelWithCredentials()
    return signIn
  }

  private func buildSignUpViewController() -> UIViewController {
    guard let signUp = R.storyboard.main.createAccountViewController() else {
      return UIViewController()
    }
    signUp.viewModel = SignUpViewModelWithEmail()
    return signUp
  }
}
