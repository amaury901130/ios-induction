//
//  CreateAccountViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    var viewModel: SignUpViewModelWithEmail!
    @IBOutlet weak var nameField: CustomTextView!
    @IBOutlet weak var emailField: CustomTextView!
    @IBOutlet weak var passwordField: CustomTextView!
    @IBOutlet weak var repeatPassword: CustomTextView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopImage()
        initView()
    }
    
    func setupTopImage() {
        topLeftImage.layer.backgroundColor = UIColor(red: 0.937, green: 0.776, blue: 0.22, alpha: 1).cgColor
        topRightImage.layer.backgroundColor = UIColor(red: 0.184, green: 0.737, blue: 0.969, alpha: 1).cgColor
        topRightImage.layer.compositingFilter = "multiplyBlendMode"
        [topLeftImage, topRightImage].forEach({ $0?.setRoundBorders(175) })
    }
    
    func initView() {
        // TODO: get this text from localise
        nameField.labelText = "NAME"
        emailField.labelText = "EMAIL"
        passwordField.labelText = "PASSWORD"
        repeatPassword.labelText = "REPEAT PASSWORD"
        
        passwordField.placeholder = "MIN 6 CHARACTERS LONG"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
