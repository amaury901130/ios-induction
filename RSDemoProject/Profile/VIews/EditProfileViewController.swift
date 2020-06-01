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
  @IBOutlet weak var userAvatar: UIImageView!
  @IBOutlet weak var orangeBubbleImage: UIView!
  @IBOutlet weak var blueBubbleImage: UIView!
  @IBOutlet weak var profileName: CustomFormField!
  @IBOutlet weak var profileEmail: CustomFormField!
  @IBOutlet weak var updatePassword: UIButton!
  let bubbleBorderRadius: CGFloat = 62
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    setUpView()
  }
  
  private func setUpView() {
    [blueBubbleImage, orangeBubbleImage].forEach {
      $0.setRoundBorders(bubbleBorderRadius)
    }
    
    orangeBubbleImage.backgroundColor = UIColor.bubbleLeft
    blueBubbleImage.backgroundColor = UIColor.bubbleRight
    blueBubbleImage.layer.compositingFilter = "multiplyBlendMode"
    
    profileName.labelText = "labelFielUserdName".localized
    profileName.textView.text = viewModel.userName
    profileName.textView.textAlignment = .center
    profileName.mandatory = true
    
    profileEmail.labelText = "labelFieldEmail".localized
    profileEmail.textView.text = viewModel.userEmail
    profileEmail.textView.textAlignment = .center
    profileEmail.mandatory = true
    
    updatePassword.addBorder(color: .black, weight: 1)
    
    [profileEmail, profileName].forEach {
      $0.textView.addTarget(
        self,
        action: #selector(textFieldDidChange(_:)),
        for: .editingChanged
      )}
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    switch textField {
    case profileEmail.textView:
      profileEmail.showError(false)
      
      if profileEmail.validate() {
        viewModel.userEmail = profileEmail.text
      }
    case profileName.textView:
      profileName.showError(false)
      
      if profileName.validate() {
        viewModel.userName = profileName.text
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
    closeController()
  }
  
  func closeController() {
    navigationController?.popToRootViewController(animated: true)
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
      closeController()
    case .none:
      break
    }
  }
}
