//
//  SignUpViewController.swift
//  RSDemoProject
//
//  Created by Rootstrap on 5/22/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
  
  // MARK: - Outlets
  var formContainer = UIStackView()
  @IBOutlet weak var signUp: UIButton!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var passwordConfirmationField: UITextField!
  
  var viewModel: SignUpViewModelWithEmail!
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    addTextViewFields()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  // MARK: - Actions
  
  @IBAction func formEditingChange(_ sender: UITextField) {
    let newValue = sender.text ?? ""
    switch sender {
    case emailField:
      viewModel.email = newValue
    case passwordField:
      viewModel.password = newValue
    case passwordConfirmationField:
      viewModel.passwordConfirmation = newValue
    default: break
    }
  }
  
  @IBAction func tapOnSignUpButton(_ sender: Any) {
    viewModel.signup()
  }
  
  func setSignUpButton(enabled: Bool) {
    signUp.alpha = enabled ? 1 : 0.5
    signUp.isEnabled = enabled
  }
    
    func addTextViewFields() {
        let customEmailField = CustomTextView()
        let customEmailField2 = CustomTextView()
        let customEmailField3 = CustomTextView()
        let customEmailField4 = CustomTextView()
        
        formContainer.axis = .vertical
        formContainer.distribution = .fillProportionally
        formContainer.spacing = 4
        formContainer.frame = CGRect(x: 0, y: 0, width: 500, height: 100)
        formContainer.addArrangedSubview(customEmailField)
        formContainer.addArrangedSubview(customEmailField2)
        formContainer.addArrangedSubview(customEmailField3)
        formContainer.addArrangedSubview(customEmailField4)
        
        view.addSubview(formContainer)
        
        formContainer.translatesAutoresizingMaskIntoConstraints = true
    
        setupConstraints()
    }
    
    func setupConstraints() {
        // todo
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
  func formDidChange() {
    setSignUpButton(enabled: viewModel.hasValidData)
  }
  
  func didUpdateState() {
    switch viewModel.state {
    case .loading:
      UIApplication.showNetworkActivity()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      showMessage(title: "Error", message: errorDescription)
    case .idle:
      UIApplication.hideNetworkActivity()
    }
  }
}
