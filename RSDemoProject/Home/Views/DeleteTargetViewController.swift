//
//  DeleteTargetViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/22/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class DeleteTargetViewController: UIViewController {
  
  var viewModel: DeleteTargetViewModel!
  
  let defaultSpacing = 1.5
  
  @IBOutlet weak var areaLabel: UILabel!
  @IBOutlet weak var areaValueLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var descriptionValueLabel: UILabel!
  @IBOutlet weak var topicLabel: UILabel!
  @IBOutlet weak var topicView: UIView!
  @IBOutlet weak var topicIcon: UIImageView!
  @IBOutlet weak var topicTitle: UILabel!
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var dismissRegionView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    
    setUpView()
  }
  
  private func setUpView() {
    [areaLabel,
     areaValueLabel,
     descriptionLabel,
     descriptionValueLabel,
     topicLabel,
     topicTitle].forEach { $0?.addSpacing(kernValue: defaultSpacing) }
    
    [areaValueLabel, descriptionValueLabel, topicView].forEach { view in
      view?.addBorder(color: .black, weight: 1)
    }

    dismissRegionView.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(dismissController)
    ))
  }
  
  private func setUpTarget() {
    areaValueLabel.text = viewModel.formattedArea
    descriptionValueLabel.text = viewModel.targetDescription
    
    guard let topic = viewModel.targetTopic else {
      return
    }
    
    topicTitle.text = topic.label
    topicIcon.kf.setImage(with: URL(string: topic.icon))
  }
  
  @objc func dismissController() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func deleteTarget(_ sender: Any) {
    viewModel.deleteTarget()
  }
}

extension DeleteTargetViewController: DeleteTargetDelegate {
  func didUpdateDeleteTargetState() {
    switch viewModel.state {
    case .targetDeleted:
      dismissController()
    case .targetLoaded:
      setUpTarget()
    case .none:
      break
    }
  }
  
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
}
