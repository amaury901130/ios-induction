//
//  ChatItemLeftTableViewCell.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/30/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class ChatItemTableViewCell: UITableViewCell {
  
  static let identifier = "ChatItemTableViewCell"
  
  @IBOutlet weak var messageRightLabel: EdgeInsetLabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var messageLeftLabel: EdgeInsetLabel!
  
  let roundMessageCorner: CGFloat = 8
  
  var viewModel: MessageViewModel! {
    didSet {
      timeLabel.text = viewModel.time
      
      messageLeftLabel.isHidden = viewModel.isMyMessage
      messageRightLabel.isHidden = !viewModel.isMyMessage
      
      if viewModel.isMyMessage {
        messageRightLabel.setRoundBorders(roundMessageCorner)
        messageRightLabel.text = viewModel.content
      } else {
        messageLeftLabel.setRoundBorders(roundMessageCorner)
        messageLeftLabel.text = viewModel.content
      }
    }
  }
}
