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
  let fieldLetterSpacing = 0.7
  var viewModel: CreateTargetViewModel!
  
  @IBOutlet weak var targetAreaField: CustomFormField!
  @IBOutlet weak var targetTitleField: CustomFormField!
  @IBOutlet weak var addTargetButton: UIButton!
  @IBOutlet weak var selectTargetTopic: UIButton!
  @IBOutlet weak var selectTopicLabel: UILabel!
  
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
    targetAreaField.textView.text = "200 m"
    
    targetTitleField.labelText = "createTargetTitleLable".localized
    targetTitleField.labelTextAlignment = .left
    targetTitleField.placeholder = "createTargetTitlePlaceholder".localized
    
    selectTopicLabel.addSpacing(kernValue: fieldLetterSpacing)
    
    selectTargetTopic.titleLabel?.addSpacing(kernValue: fieldLetterSpacing)
    selectTargetTopic.addBorder(color: .black, weight: 1)
  }
  
  @IBAction func selectTopic(_ sender: Any) {
    //todo
  }
  
  @IBAction func addTarget(_ sender: Any) {
    //todo
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
