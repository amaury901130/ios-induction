//
//  ChatModalViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/4/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class ChatModalViewController: UIViewController {
  
  var viewModel: ChatModalViewModel!
  let bubbleBorderRadius: CGFloat = 39
  let avatarBorderRadius: CGFloat = 22
  @IBOutlet weak var userNameLabel: EdgeInsetLabel!
  @IBOutlet weak var userAvatarImage: UIImageView!
  @IBOutlet weak var rightBubbleView: UIView!
  @IBOutlet weak var leftBubbleView: UIView!
  @IBOutlet weak var happyFaceRightImage: UIImageView!
  @IBOutlet weak var happyFaceLeftImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setUpView()
  }
  
  func setUpView() {
    rightBubbleView.setRoundBorders(bubbleBorderRadius)
    rightBubbleView.layer.compositingFilter = "multiplyBlendMode"
    leftBubbleView.setRoundBorders(bubbleBorderRadius)
    
    happyFaceLeftImage.image = R.image.happyFace()
    happyFaceRightImage.image = R.image.happyFace()
    
    userAvatarImage.setRoundBorders(avatarBorderRadius)
    userAvatarImage.kf.setImage(
      with: viewModel.userImageURL,
      placeholder: R.image.avatarPlaceholder()
    )
    userNameLabel.text = viewModel.userName
  }
  
  @IBAction func skip(_ sender: Any) {
    dismiss(animated: true)
  }
}
