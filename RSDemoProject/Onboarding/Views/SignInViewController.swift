//
//  SignInViewController.swift
//  RSDemoProject
//
//  Created by Rootstrap on 5/22/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: UIViewController {
  
  let facebookPermissions = ["email"]
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
    //adding facebook button spacing
    connectWithFacebook.addSpacing(kernValue: 2.4)
  }
  
  @IBAction func tapOnSignInButton(_ sender: Any) {
    if validateForm() {
      viewModel.login(email: emailField.text, password: passwordField.text)
    }
  }
  
  @IBAction func facebookLogin() {
    let loginManager = LoginManager()
    loginManager.logIn(
      permissions: facebookPermissions,
      from: self
    ) { [weak self] (result, error) in
        guard error == nil else {
          self?.showMessage(
            title: "Error",
            message: error?.localizedDescription ?? "errorFBLogin".localized)
          return
        }
        
        guard let result = result, !result.isCancelled else {
          return
        }
        
        self?.viewModel.facebookLoginRequestSucceded()
    }
  }
  
  func validateForm() -> Bool {
    var formError = false
    
    [emailField, passwordField].forEach {
      formError = !$0.validate() || formError
    }
    
    return !formError
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func tapOnSignUpButton(_ sender: Any) {
    navigateTo(OnboardingRoutes.signUp)
  }
  
  private func enableButtons(_ disable: Bool = true) {
    [signInButton, signUpButton, connectWithFacebook].forEach { $0?.setEnable(disable) }
  }
}

extension SignInViewController: SignInViewModelDelegate {
  func didUpdateState() {
    switch viewModel.state {
    case .loading:
      UIApplication.showNetworkActivity()
      enableButtons(false)
      [signInButton, signUpButton, connectWithFacebook].forEach { $0?.setEnable(false) }
    case .idle:
      UIApplication.hideNetworkActivity()
      enableButtons()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      enableButtons()
      showMessage(title: "Error", message: errorDescription)
    }
  }
  
  func didUpdateSignInState() {
    switch viewModel.signInState {
    case .signedIn:
      UIApplication.hideNetworkActivity()
      navigateTo(HomeRoutes.main)
    case .none: break
    }
  }
}
