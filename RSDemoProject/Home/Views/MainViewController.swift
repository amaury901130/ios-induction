//
//  MainViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import MapKit
import PanModal

class MainViewController: UIViewController {
  
  let mainTitleSpacing = 1.95
  let createTargetLabelSpacing = 1.65
  
  var viewModel: MainViewModel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var mainTitle: UILabel!
  @IBOutlet weak var createTargetLabel: UILabel!
  @IBOutlet weak var createNewTarget: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    initMap()
    initView()
  }

  private func initMap() {
    viewModel.requestCurrentLocation()
  }
  
  private func initView() {
    createTargetLabel.addSpacing(kernValue: createTargetLabelSpacing)
    mainTitle.addSpacing(kernValue: mainTitleSpacing)
    
    createNewTarget.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(self.showCreateTargetView)
    ))
  }
  
  //WIP
  @objc private func showCreateTargetView() {
    // swiftlint:disable force_cast
    let drawerViewController =
      HomeRoutes.createTarget.screen as! CreateTargetViewController
    presentPanModal(drawerViewController)
    // swiftlint:enable force_cast
  }
  
  private func addCurrentLocation(_ location: CLLocation) {
    mapView.center(location)
    mapView.addAnnotation(location: location)
  }
}

extension MainViewController: MainViewModelDelegate {
  func didUpdateLocation(_ location: CLLocation) {
    addCurrentLocation(location)
  }
}
