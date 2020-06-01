//
//  UpdatePasswordViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/1/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

// WIP
// todo: viewmodel, actions, validations
class UpdatePasswordViewController: UIViewController {
  
  @IBOutlet weak var currentPasswordField: CustomFormField!
  @IBOutlet weak var newPasswordField: CustomFormField!
  @IBOutlet weak var confirmNewPassword: CustomFormField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpFields()
  }
  
  private func setUpFields() {
    currentPasswordField.mandatory = true
    currentPasswordField.labelText = "updatePasswordLabel".localized
    currentPasswordField.label.numberOfLines = 2
    
    newPasswordField.mandatory = true
    newPasswordField.labelText = "labelFieldNewPassword".localized
   
    confirmNewPassword.mandatory = true
    confirmNewPassword.labelText = "labelFieldConfirmNewPassword".localized
  }
  
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
