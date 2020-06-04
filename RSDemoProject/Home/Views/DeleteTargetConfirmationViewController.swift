//
//  DeleteTargetConfirmationViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/3/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

protocol DeleteConfirmationDelegate: class {
  func didTargetDelete()
}

class DeleteTargetConfirmationViewController: UIViewController {
  
  var viewModel: DeleteTargetConfirmationViewModel!
  let backIconCornerRadius: CGFloat = 28
  weak var deleteTargetDelegate: DeleteConfirmationDelegate?

  @IBOutlet weak var targetIcon: UIImageView!
  @IBOutlet weak var targetTitleLabel: EdgeInsetLabel!
  @IBOutlet weak var dialogDescriptionLabel: EdgeInsetLabel!
  @IBOutlet weak var targetIconBack: UIView!
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
  }
  
  private func setUpView() {
    targetIconBack.setRoundBorders(backIconCornerRadius)
    dialogDescriptionLabel.text = "deleteConfirmationMessage".localized
    targetTitleLabel.text = viewModel.targetDescription
    targetIcon.kf.setImage(with: viewModel.targetIcon)
  }
  
  @IBAction func deleteTarget(_ sender: Any) {
    viewModel.deleteTarget()
  }
  
  @IBAction func cancel(_ sender: Any) {
    dismissController()
  }
  
  private func dismissController() {
    dismiss(animated: true, completion: nil)
  }
  
  private func setButtonsEnabled(_ enabled: Bool) {
    deleteButton.setEnable(enabled)
    cancelButton.setEnable(enabled)
  }
}

extension DeleteTargetConfirmationViewController: DeleteTargetConfirmationDelegate {
  func didUpdateDeleteTargetState() {
    switch viewModel.state {
    case .targetDeleted:
      deleteTargetDelegate?.didTargetDelete()
      dismissController()
    case .targetLoaded:
      setUpView()
    case .none:
      break
    }
  }
  
  func didUpdateState() {
    var error = false
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
    case .idle:
      UIApplication.hideNetworkActivity()
    case .error(let errorDescription):
      error = true
      UIApplication.hideNetworkActivity()
      showMessage(title: "Error", message: errorDescription)
    }
    
    setButtonsEnabled(error)
  }
}
