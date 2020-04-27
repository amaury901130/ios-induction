//
//  SignInViewController.swift
//  RSDemoProject
//
//  Created by Rootstrap on 5/22/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  
  // MARK: - Outlets
  
  var viewModel: SignInViewModelWithCredentials!
  
  @IBOutlet weak var topLeftImage: UIView!
  @IBOutlet weak var topRightImage: UIView!
  @IBOutlet weak var emailField: CustomFormField!
  @IBOutlet weak var passwordField: CustomFormField!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var screenTitle: UILabel!
  @IBOutlet weak var connectWithFacebook: UIButton!
  
  // MARK: - Lifecycle Events
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setupTopImage()
    initView()
  }
  
  func setupTopImage() {
    topLeftImage.layer.backgroundColor = App.yellowColor
    topRightImage.layer.backgroundColor = App.blueColor
    topRightImage.layer.compositingFilter = "multiplyBlendMode"
    [topLeftImage, topRightImage].forEach { $0?.setRoundBorders(175) }
  }
  
  func initView() {
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    [emailField, passwordField].forEach {
      $0?.mandatory = true
    }
    //labels
    emailField.labelText = "labelFieldEmail".localized
    passwordField.labelText = "labelFieldPassword".localized
    
    //set text field types
    passwordField.isSecure()
    emailField.setKeyboardType(type: .emailAddress)
    
    //set errors
    emailField.mandatoryText = "errorEmptyEmail".localized
    passwordField.mandatoryText = "errorEmptyPassword".localized
    emailField.errorText = "errorFieldEmail".localized
    
    //set validations
    emailField.validationPattern = Validations.emailPattern
    //adding title spacing
    screenTitle.addSpacing(kernValue: 3)
  }
  
  @IBAction func tapOnSignInButton(_ sender: Any) {
    if validateForm() {
      viewModel.login(email: emailField.text, password: passwordField.text)
    }
  }
  
  @IBAction func facebookLogin() {
    viewModel.facebookLogin()
  }
  
  func validateForm() -> Bool {
    var formError = false
    [emailField, passwordField].forEach {
      formError = !$0.validate() || formError
    }

    return !formError
  }
  
  @IBAction func tapOnSignUpButton(_ sender: Any) {
    navigateTo(OnboardingRoutes.signUp)
  }
  
  private func navigateTo(_ route: Route) {
    AppNavigator.shared.navigate(
      to: route,
      with: .push)
  }
}

extension SignInViewController: SignInViewModelDelegate {
  func didUpdateState() {
    switch viewModel.state {
    case .loading:
      UIApplication.showNetworkActivity()
      [signInButton, signUpButton].forEach { $0?.setEnable(false)}
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      [signInButton, signUpButton].forEach { $0?.setEnable()}
      showMessage(title: "Error", message: errorDescription)
    case .idle:
      UIApplication.hideNetworkActivity()
      [signInButton, signUpButton].forEach { $0?.setEnable()}
    case .signedIn:
      UIApplication.hideNetworkActivity()
      navigateTo(OnboardingRoutes.firstScreen)
    }
  }
}
