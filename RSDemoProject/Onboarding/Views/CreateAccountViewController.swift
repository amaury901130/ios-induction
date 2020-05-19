//
//  CreateAccountViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

  var viewModel: SignUpViewModelWithEmail!
  
  @IBOutlet weak var nameField: CustomFormField!
  @IBOutlet weak var emailField: CustomFormField!
  @IBOutlet weak var passwordField: CustomFormField!
  @IBOutlet weak var repeatPassword: CustomFormField!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var topLeftImage: UIView!
  @IBOutlet weak var topRightImage: UIView!
  @IBOutlet weak var screenTitle: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    setupTopImage()
    initView()
  }
  
  func setupTopImage() {
    topLeftImage.layer.backgroundColor = UIColor.bubbleLeft.cgColor
    topRightImage.layer.backgroundColor = UIColor.bubbleRight.cgColor
    topRightImage.layer.compositingFilter = "multiplyBlendMode"
    [topLeftImage, topRightImage].forEach { $0?.setRoundBorders(175) }
  }
  
  func initView() {
    [nameField, emailField, passwordField, repeatPassword].forEach {
      $0?.mandatory = true
    }
    //labels
    nameField.labelText = "labelFieldName".localized
    emailField.labelText = "labelFieldEmail".localized
    passwordField.labelText = "labelFieldPassword".localized
    repeatPassword.labelText =  "labelFieldConfirmPassword".localized
    
    //set text field types
    [passwordField, repeatPassword].forEach { $0.isSecure() }
    emailField.setKeyboardType(type: .emailAddress)
    nameField.setKeyboardType(type: .namePhonePad)
    
    //set errors
    nameField.mandatoryText = "errorFieldName".localized
    emailField.mandatoryText = "errorEmptyEmail".localized
    passwordField.mandatoryText = "errorEmptyPassword".localized
    repeatPassword.mandatoryText = "errorEmptyRepeat".localized
    passwordField.errorText = "errorFieldPassword".localized
    repeatPassword.errorText = "errorFieldConfirmPassword".localized
    emailField.errorText = "errorFieldEmail".localized
    
    //set validations
    emailField.validationPattern = Validations.emailPattern
    passwordField.validationPattern = Validations.passwordPattern
    // placeholders
    passwordField.placeholder =  "placeholderPassword".localized
    
    //adding title spacing
    screenTitle.addSpacing(kernValue: 3)
  }
  
  @IBAction func tapOnSignUpButton(_ sender: Any) {
    if validateForm() {
      viewModel.signup(
        name: nameField.text,
        email: emailField.text,
        password: passwordField.text)
    }
  }

  private func validateForm() -> Bool {
    var formError = false
    
    [nameField, emailField, passwordField, repeatPassword].forEach {
      formError = !$0.validate() || formError
    }
    
    return !formError && validatePassword()
  }
  
  private func validatePassword() -> Bool {
    guard passwordField.text == repeatPassword.text else {
      repeatPassword.showError()
      return false
    }
    
    return true
  }
  
  @IBAction func tapOnSignInButton(_ sender: Any) {
    navigateTo(OnboardingRoutes.signIn)
  }
}

extension CreateAccountViewController: SignUpViewModelDelegate {
  func didUpdateState() {
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
      [signUpButton, signInButton].forEach { $0.setEnable(false) }
    case .idle:
      UIApplication.hideNetworkActivity()
      [signUpButton, signInButton].forEach { $0.setEnable(false) }
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      [signUpButton, signInButton].forEach { $0.setEnable() }
      showMessage(title: "Error", message: errorDescription)
    }
  }
  
  func didUpdateSignUpState() {
    switch viewModel.state {
    case .signedUp:
      UIApplication.hideNetworkActivity()
      navigateTo(HomeRoutes.main)
    case .none: break
    }
  }
}
