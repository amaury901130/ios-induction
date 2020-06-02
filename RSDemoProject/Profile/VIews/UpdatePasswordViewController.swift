//
//  UpdatePasswordViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/1/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
  
  var viewModel: UpdatePasswordViewModel!
  
  @IBOutlet weak var currentPasswordField: CustomFormField!
  @IBOutlet weak var newPasswordField: CustomFormField!
  @IBOutlet weak var confirmNewPasswordField: CustomFormField!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.delegate = self
    setUpFields()
    setUpListeners()
  }
  
  private func setUpFields() {
    currentPasswordField.mandatory = true
    currentPasswordField.labelText = "updatePasswordLabel".localized
    currentPasswordField.label.numberOfLines = 2
    currentPasswordField.isSecure()
    
    newPasswordField.mandatory = true
    newPasswordField.labelText = "labelFieldNewPassword".localized
    newPasswordField.isSecure()
    newPasswordField.validationPattern = Validations.passwordPattern
    newPasswordField.errorText = "errorFieldPassword".localized
    
    confirmNewPasswordField.mandatory = true
    confirmNewPasswordField.labelText = "labelFieldConfirmNewPassword".localized
    confirmNewPasswordField.errorText = "errorFieldConfirmPassword".localized
    confirmNewPasswordField.isSecure()
  }
  
  private func setUpListeners() {
    [currentPasswordField, newPasswordField, confirmNewPasswordField].forEach {
      $0.textView.addTarget(
        self,
        action: #selector(textFieldDidChange(_:)),
        for: .editingChanged
      )}
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    switch textField {
    case currentPasswordField.textView:
      currentPasswordField.showError(false)
      
      if currentPasswordField.validate() {
        viewModel.currentPassword = currentPasswordField.text
      }
    case newPasswordField.textView:
      newPasswordField.showError(false)
      
      if newPasswordField.validate() {
        viewModel.newPassword = newPasswordField.text
      }
    case confirmNewPasswordField.textView:
      confirmNewPasswordField.showError(false)
      if confirmNewPasswordField.validate() {
        viewModel.repeatedNewPassword = confirmNewPasswordField.text
      }
    default:
      break
    }
  }
  
  private func disableButtons() {
    doneButton.setEnable(false)
    cancelButton.setEnable(false)
  }
  
  private func enableButtons() {
    doneButton.setEnable()
    cancelButton.setEnable()
  }
  
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func updatePassword(_ sender: Any) {
    if
      currentPasswordField.validate(),
      newPasswordField.validate(),
      confirmNewPasswordField.validate(),
      viewModel.newRepeatedPasswordIsValid() {
      viewModel.updatePassword()
    }
  }
}

extension UpdatePasswordViewController: UpdatePasswordViewModelDelegate {
  func didUpdatePasswordState() {
    switch viewModel.state {
    case .paswwordUpdated:
      showMessage(
        title: "messageTitleSuccess".localized,
        message: "messageBodyPasswordSuccess".localized
      )
    case .newPasswordError:
      confirmNewPasswordField.showError()
    case .none:
      break
    }
  }
  
  func didUpdateState() {
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
      disableButtons()
    case .idle:
      UIApplication.hideNetworkActivity()
      disableButtons()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      enableButtons()
      showMessage(title: "Error", message: errorDescription)
    }
  }
}
