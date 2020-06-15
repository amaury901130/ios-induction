//
//  MainViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
  
  let mainTitleSpacing = 1.95
  let conversationCountRadius: CGFloat = 6
  let createTargetLabelSpacing = 1.65
  
  var viewModel: MainViewModel!
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var mainTitle: UILabel!
  @IBOutlet weak var createTargetLabel: UILabel!
  @IBOutlet weak var createNewTarget: UIView!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var unreadMessagesLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    initMap()
    initView()
  }
  
  private func initMap() {
    viewModel.requestCurrentLocation()
    
    mapView.delegate = self
    
    mapView.addGestureRecognizer(
      UILongPressGestureRecognizer(
        target: self,
        action: #selector(centerMap)
    ))
  }

  @IBAction func editProfile(_ sender: Any) {
    navigateTo(ProfileRoutes.editProfile, withTransition: .pushFromLeft)
  }
  
  private func initView() {
    createTargetLabel.addSpacing(kernValue: createTargetLabelSpacing)
    mainTitle.addSpacing(kernValue: mainTitleSpacing)
    
    createNewTarget.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(showCreateTargetForm)
    ))
    
    if let avatar = viewModel.userAvatar {
      profileButton.kf.setImage(with: URL(string: avatar), for: .normal)
    }
    
    unreadMessagesLabel.setRoundBorders(conversationCountRadius)
    unreadMessagesLabel.textColor = .white
    unreadMessagesLabel.isHidden = true
  }
  
  @objc private func centerMap(gestureRecognizer: UIGestureRecognizer) {
    guard gestureRecognizer.state == UIGestureRecognizer.State.began else {
      return
    }
    
    let touchPoint = gestureRecognizer.location(in: mapView)
    let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
    let location = CLLocation(
      latitude: newCoordinates.latitude,
      longitude: newCoordinates.longitude
    )
    
    mapView.center(location)
  }
  
  private func showModalForSelectedTarget(_ target: Target) {
    navigateTo(
      HomeRoutes.deleteTarget(target),
      withTransition: .modal(presentationStyle: .overCurrentContext)
    )
  }
  
  private func reloadOverlay() {
    mapView.annotations.forEach { view in
      if
        let targetAnnotation = view as? PinAnnotation,
        let overlay = targetAnnotation.pinView.overlay
      {
        mapView.addOverlay(overlay)
      }
    }
  }
  
  @objc private func showCreateTargetForm() {
    navigateTo(
      HomeRoutes.createTarget(self),
      withTransition: .modal(presentationStyle: .overCurrentContext)
    )
  }
  
  @objc private func selectTarget(_ target: Target) {
    viewModel.selectedTarget = target
  }
  
  private func addCurrentLocation(_ location: CLLocation) {
    mapView.center(location)
    mapView.addAnnotation(PinAnnotation(location))
  }
  
  func addTargetAnnotations() {
    viewModel.userTargets.forEach { target in
      mapView.addAnnotation(
        PinAnnotation(
          target.location,
          pinType: .target(target: target)
        )
      )
    }
  }
  
  func showUnreadMessages() {
    guard viewModel.unreadMessages > 0 else {
      unreadMessagesLabel.isHidden = false
      return
    }
    
    unreadMessagesLabel.text = String(viewModel.unreadMessages)
    unreadMessagesLabel.isHidden = false
  }
}

extension MainViewController: TargetCreationDelegate {
  func didCreateTarget(targetMatch: TargetMatch) {
    viewModel.newTargetMatch = targetMatch
  }
}

extension MainViewController: MKMapViewDelegate {
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    guard
      let customPointAnnotation = annotation as? PinAnnotation,
      let annotationView = customPointAnnotation.pinView
    else {
      return MKAnnotationView(annotation: annotation, reuseIdentifier: "unknown")
    }
    
    var overlayCircle: MKCircle
    var radius = viewModel.defaultMapRadius
    switch customPointAnnotation.pinType {
    case .target(let target):
      radius = target.radius
    default:
      break
    }
    
    overlayCircle = MKCircle(
      center: annotation.coordinate,
      radius: CLLocationDistance(radius)
    )
    
    mapView.addOverlay(overlayCircle)
    annotationView.overlay = overlayCircle
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard let annotation = view as? ImageAnnotationView else {
        return
    }
    
    switch annotation.pinType {
    case .target(let target):
      viewModel.selectedTarget = target
    default:
      break
    }
  }
  
  func mapView(
    _ mapView: MKMapView,
    rendererFor overlay: MKOverlay
  ) -> MKOverlayRenderer {
    guard let circleOverlay = overlay as? MKCircle else {
      return MKOverlayRenderer()
    }
    
    let circleView = MKCircleRenderer(overlay: circleOverlay)
    var color = UIColor.overlayNormal
    if
      let selectedTarget = viewModel.selectedTarget,
      circleView.circle.coordinate.latitude == selectedTarget.latitude,
      circleView.circle.coordinate.longitude == selectedTarget.longitude
    {
      color = UIColor.overlaySelected
    }
    
    circleView.fillColor = color
    return circleView
  }
}

extension MainViewController: MainViewModelDelegate {
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
  
  func didUpdateMainState() {
    switch viewModel.state {
    case .locationUpdated:
      guard let location = viewModel.currentLocation else {
        return
      }
      
      addCurrentLocation(location)
    case .targetsLoaded:
      addTargetAnnotations()
    case .targetSelected:
      guard let target = viewModel.selectedTarget else {
        return
      }
      
      showModalForSelectedTarget(target)
      reloadOverlay()
    case .newMatchCreated:
      guard let matchConversation = viewModel.matchConversation else {
        return
      }
      navigateTo(
        ChatRoutes.chatModal(conversation: matchConversation),
        withTransition: .modal(presentationStyle: .overCurrentContext)
      )
    case .conversationsLoaded:
      showUnreadMessages()
    case .none:
      break
    }
  }
}
