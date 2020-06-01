//
//  ProfileViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
  
  var viewModel: EditProfileViewModel!
  @IBOutlet weak var userAvatarImage: UIImageView!
  @IBOutlet weak var orangeBubbleImage: UIView!
  @IBOutlet weak var blueBubbleImage: UIView!
  @IBOutlet weak var profileNameField: CustomFormField!
  @IBOutlet weak var profileEmailField: CustomFormField!
  @IBOutlet weak var updatePasswordButton: UIButton!
  let bubbleBorderRadius: CGFloat = 62
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    setUpView()
  }
  
  private func setUpView() {
    blueBubbleImage.setRoundBorders(bubbleBorderRadius)
    orangeBubbleImage.setRoundBorders(bubbleBorderRadius)
    
    orangeBubbleImage.backgroundColor = UIColor.bubbleLeft
    blueBubbleImage.backgroundColor = UIColor.bubbleRight
    blueBubbleImage.layer.compositingFilter = "multiplyBlendMode"
    
    profileNameField.labelText = "labelFielUserdName".localized
    profileNameField.textView.text = viewModel.userName
    profileNameField.textView.textAlignment = .center
    profileNameField.mandatory = true
    
    profileEmailField.labelText = "labelFieldEmail".localized
    profileEmailField.textView.text = viewModel.userEmail
    profileEmailField.textView.textAlignment = .center
    profileEmailField.mandatory = true
    
    updatePasswordButton.addBorder(color: .black, weight: 1)
    
    [profileEmailField, profileNameField].forEach { $0.textView.addTarget(
      self,
      action: #selector(textFieldDidChange(_:)),
      for: .editingChanged
    )}
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    switch textField {
    case profileEmailField.textView:
      profileEmailField.showError(false)
      
      if profileEmailField.validate() {
        viewModel.userEmail = profileEmailField.text
      }
    case profileNameField.textView:
      profileNameField.showError(false)
      
      if profileNameField.validate() {
        viewModel.userName = profileNameField.text
      }
    default:
      break
    }
  }
  
  @IBAction func updatePassword(_ sender: Any) {
    navigateTo(
      ProfileRoutes.updatePassword,
      withTransition: .modal(presentationStyle: .overCurrentContext)
    )
  }
  
  @IBAction func logOut(_ sender: Any) {
    viewModel.logOut()
  }
  
  @IBAction func saveChanges(_ sender: Any) {
    viewModel.updateProfile()
  }
  
  @IBAction func exitController(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  func logOut() {
    navigateTo(OnboardingRoutes.signIn)
  }
}

extension EditProfileViewController: EditProfileViewModelDelegate {
  func didUpdateState() {
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
    case .idle:
      UIApplication.hideNetworkActivity()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      showMessage(title: "Error", message: errorDescription)
    }
  }
  
  func didUpdateProfileState() {
    switch viewModel.state {
    case .profileUpdated:
      showMessage(title: "Success", message: "You profile has been updated")
    case .profileLoggedOut:
      logOut()
    case .none:
      break
    }
  }
}
