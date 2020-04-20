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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTopImage()
    initView()
  }
  
  func setupTopImage() {
    topLeftImage.layer.backgroundColor = App.topLeftColor
    topRightImage.layer.backgroundColor = App.topRightColor
    topRightImage.layer.compositingFilter = "multiplyBlendMode"
    [topLeftImage, topRightImage].forEach { $0?.setRoundBorders(175) }
  }
  
  func initView() {
    //labels
    nameField.labelText = App.getString(key: "labelFieldName")
    emailField.labelText = App.getString(key: "labelFieldEmail")
    passwordField.labelText = App.getString(key: "labelFieldPassword")
    repeatPassword.labelText =  App.getString(key: "labelFieldConfirmPassword")

    // placeholders
    passwordField.placeholder =  App.getString(key: "placeholderPassword")
  }
}
