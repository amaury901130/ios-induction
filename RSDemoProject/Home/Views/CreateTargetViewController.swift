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
  @IBOutlet weak var dismissRegion: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    initView()
  }
  
  //WIP setup fields
  private func initView() {
    setupListener()
    
    targetAreaField.labelText = "createTargetAreaLable".localized
    targetAreaField.errorText = "errorFieldTargetArea".localized
    targetAreaField.mandatoryText = "errorFieldTargetEmptyArea".localized
    targetAreaField.mandatory = true
    targetAreaField.validationPattern = Validations.areaPattern
    targetAreaField.labelTextAlignment = .left
    targetAreaField.textFieldTextAlignment = .center
    targetAreaField.textView.text = viewModel.targetArea
    
    targetTitleField.labelText = "createTargetTitleLable".localized
    targetTitleField.errorText = "errorFieldTargetTitle".localized
    targetTitleField.labelTextAlignment = .left
    targetTitleField.placeholder = "createTargetTitlePlaceholder".localized
    
    selectTopicLabel.addSpacing(kernValue: fieldLetterSpacing)
    
    selectTargetTopic.titleLabel?.addSpacing(kernValue: fieldLetterSpacing)
    selectTargetTopic.addBorder(color: .black, weight: 1)
    
    dismissRegion.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(dismissController)
    ))
    
    selectTargetTopic.setTitle("createTargetTopicTitle".localized, for: .normal)
  }
  
  private func setupListener() {
    [targetAreaField, targetTitleField].forEach {
      $0.textView.addTarget(
        self,
        action: #selector(textFieldDidChange(_:)),
        for: .editingChanged
      )}
    
    targetAreaField.textView.addTarget(
      self,
      action: #selector(textFieldEditingEnd(_:)),
      for: .editingDidEnd
    )
    
    targetAreaField.textView.addTarget(
      self,
      action: #selector(textFieldEditingBegin(_:)),
      for: .editingDidBegin
    )
  }
  
  @objc func textFieldEditingEnd(_ textField: UITextField) {
    guard
      targetAreaField.text.isNotEmpty,
      !targetAreaField.text.contains(viewModel.areaUnit)
    else {
      return
    }
    
    let textview = targetAreaField.textView
    textview.text = "\(targetAreaField.text) \(viewModel.areaUnit)"
  }
  
  @objc func textFieldEditingBegin(_ textField: UITextField) {
     targetAreaField.textView.text = ""
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    switch textField {
    case targetAreaField.textView:
      targetAreaField.showError(false)
      
      if targetAreaField.validate() {
        viewModel.targetArea = targetAreaField.text
      }
    case targetTitleField.textView:
      viewModel.targetTitle = targetTitleField.text
    default:
      break
    }
  }
  
  @objc func dismissController() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func selectTopic(_ sender: Any) {
    navigateTo(
      HomeRoutes.topicSelection(viewModel),
      withTransition: .modal(presentationStyle: .overCurrentContext)
    )
  }
  
  @IBAction func addTarget(_ sender: Any) {
    viewModel.createTarget()
  }
  
  private func updateTopicButton() {
    guard viewModel.selectedTopic != nil else {
      return
    }

    selectTargetTopic.setTitle(viewModel.topicTitle, for: .normal)
    selectTargetTopic.setIcon(url: viewModel.topicImage)
  }
  
  private func errorTitle(_ error: Bool) {
    targetTitleField.showError(error)
  }
  
  private func errorArea(_ error: Bool) {
     targetAreaField.showError(error)
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
    case .targetCreated(let response):
      //todo: back with the target response
      dismiss(animated: true, completion: nil)
    case .didSelectTopic:
      updateTopicButton()
    case .errorTitle(let error):
      errorTitle(error)
    case .errorArea(let error):
      errorArea(error)
    case .none: break
    }
  }
}
