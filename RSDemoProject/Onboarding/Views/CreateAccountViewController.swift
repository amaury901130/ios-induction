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
  @IBOutlet weak var topLeftImage: UIView!
  @IBOutlet weak var topRightImage: UIView!
  @IBOutlet weak var screenTitle: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    //labels
    nameField.labelText = "labelFieldName".localized
    emailField.labelText = "labelFieldEmail".localized
    passwordField.labelText = "labelFieldPassword".localized
    repeatPassword.labelText =  "labelFieldConfirmPassword".localized

    // placeholders
    passwordField.placeholder =  "placeholderPassword".localized
    
    screenTitle.addSpacing(kernValue: 3)
  }
}
