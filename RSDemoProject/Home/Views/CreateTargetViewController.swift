//
//  CreateTargetViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/5/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CreateTargetViewController: UIViewController {
  
  let contentHeight: CGFloat = 340
  var viewModel: CreateTargetViewModel!
  
  @IBOutlet weak var targetAreaField: CustomFormField!
  @IBOutlet weak var targetTitleField: CustomFormField!
  @IBOutlet weak var targetTopicField: CustomFormField!
  @IBOutlet weak var addTargetButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    initView()
  }
  
  //WIP setup fields
  private func initView() {
    targetAreaField.labelText = "createTargetAreaLable".localized
    targetAreaField.labelTextAlignment = .left
    targetAreaField.textFieldTextAlignment = .center
    //WIP
    targetAreaField.textView.text = "200 m"
    targetAreaField.textView.isEnabled = false
    targetAreaField.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(selectArea)
    ))
    
    targetTitleField.labelText = "createTargetTitleLable".localized
    targetTitleField.labelTextAlignment = .left
    targetTitleField.placeholder = "createTargetTitlePlaceholder".localized
    
    //WIP
    targetTopicField.labelText = "createTargetTopicLable".localized
    targetTopicField.labelTextAlignment = .left
    targetTopicField.textFieldTextAlignment = .center
    targetTopicField.textView.text = "createTargetTopicTitle".localized
    targetTopicField.textView.isEnabled = false
    targetAreaField.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(selectTopic)
    ))
  }
  
  @objc func selectArea() {
    //todo
  }
  
  @objc func selectTopic() {
    //todo
  }
  
  
  @IBAction func addTarget(_ sender: Any) {
    viewModel.state = .targetCreated
  }
}

extension CreateTargetViewController: CreateTargetDelegate {
  func didUpdateState() {
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
      addTargetButton.setEnable(false)
    case .idle:
      UIApplication.hideNetworkActivity()
      addTargetButton.setEnable(false)
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      addTargetButton.setEnable()
      showMessage(title: "Error", message: errorDescription)
    }
  }
  
  func didUpdateCreateTargetState() {
    switch viewModel.state {
    case .targetCreated:
      UIApplication.hideNetworkActivity()
      dismiss(animated: true, completion: nil)
    case .none: break
    }
  }
}
