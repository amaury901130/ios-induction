//
//  HomeViewController.swift
//  RSDemoProject
//
//  Created by Rootstrap on 5/23/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var logOut: UIButton!
  
  var viewModel: HomeViewModel!
  
  // MARK: - Lifecycle Events
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    logOut.setRoundBorders(22)
  }
  
  // MARK: - Actions
  
  @IBAction func tapOnGetMyProfile(_ sender: Any) {
    viewModel.loadUserProfile()
  }
  
  @IBAction func tapOnLogOutButton(_ sender: Any) {
    viewModel.logoutUser()
  }
  
  private func navigateTo(_ route: Route) {
    AppNavigator.shared.navigate(
      to: route,
      with: .push)
  }
}

extension HomeViewController: HomeViewModelDelegate {
  func didUpdateHomeState() {
    switch viewModel.homeState {
    case .logOut:
      navigateTo(OnboardingRoutes.signIn)
    case .none: break
    }
  }
  
  func didViewModelState() {
    switch viewModel.state {
    case .idle:
      UIApplication.hideNetworkActivity()
      showMessage(title: "My Profile", message: "email: \(viewModel.userEmail ?? "")")
    case .loading:
      UIApplication.showNetworkActivity()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      showMessage(
        title: "My Profile",
        message: "email: \(viewModel.userEmail ?? "") error: \(errorDescription)")
    }
  }
}
