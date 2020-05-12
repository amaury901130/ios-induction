//
//  CreateTargetViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/5/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import PanModal

class CreateTargetViewController: UIViewController {
  
  let contentHeight: CGFloat = 340
  
  @IBOutlet weak var targetAreaField: CustomFormField!
  @IBOutlet weak var targetTitleField: CustomFormField!
  @IBOutlet weak var targetTopicField: CustomFormField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    targetTitleField.labelText = "createTargetTitleLable".localized
    targetTitleField.labelTextAlignment = .left
    targetTitleField.placeholder = "createTargetTitlePlaceholder".localized
    
    //WIP
    targetTopicField.labelText = "createTargetTopicLable".localized
    targetTopicField.labelTextAlignment = .left
    targetTopicField.textFieldTextAlignment = .center
    targetTopicField.textView.text = "createTargetTopicTitle".localized
    targetTopicField.textView.isEnabled = false
  }
}

extension CreateTargetViewController: PanModalPresentable {
  
  var panScrollable: UIScrollView? {
    nil
  }

  var shortFormHeight: PanModalHeight {
    .contentHeight(contentHeight)
  }
  
  var longFormHeight: PanModalHeight {
    .contentHeight(contentHeight)
  }
  
  var panModalBackgroundColor: UIColor {
    UIColor(white: 1, alpha: 0)
  }
  
  var showDragIndicator: Bool {
    false
  }
  
  var allowsExtendedPanScrolling: Bool {
    false
  }
}
