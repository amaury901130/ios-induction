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
    
    mapView.delegate = self
    
    mapView.addGestureRecognizer(
      UILongPressGestureRecognizer(
        target: self,
        action: #selector(centerMap)
    ))
    
    mapView.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(mapTap(_:))
      )
    )
  }
  
  @objc func mapTap(_ gesture: UITapGestureRecognizer) {
    let point = gesture.location(in: mapView)
    let coordinate = mapView.convert(point, toCoordinateFrom: nil)
    let mappoint = MKMapPoint(coordinate)
    
    for overlay in mapView.overlays {
      guard let overlayCircle = overlay as? CirleOverlay else {
        return
      }
      
      let centerMP = MKMapPoint(overlayCircle.coordinate)
      let distance = mappoint.distance(to: centerMP)
      if distance <= overlayCircle.radius * 2 {
        guard let target = overlayCircle.target else {
          return
        }
        viewModel.selectedTarget = target
      }
      
      // this func. reload the circle if it already exist
      mapView.addOverlay(overlayCircle)
    }
  }
  
  private func initView() {
    createTargetLabel.addSpacing(kernValue: createTargetLabelSpacing)
    mainTitle.addSpacing(kernValue: mainTitleSpacing)
    
    createNewTarget.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(showCreateTargetForm)
    ))
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

  @objc private func showCreateTargetForm() {
    navigateTo(
      HomeRoutes.createTarget,
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
}

extension MainViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard
      let customPointAnnotation = annotation as? PinAnnotation,
      let annotationView = customPointAnnotation.pinView
      else {
        return MKAnnotationView(annotation: annotation, reuseIdentifier: "unknown")
    }
    
    var overlayCircle: CirleOverlay
    
    switch customPointAnnotation.pinType {
    case .target(let target):
      overlayCircle = CirleOverlay(
        center: annotation.coordinate,
        radius: CLLocationDistance(target.radius)
      )
      overlayCircle.target = target
    default:
      overlayCircle = CirleOverlay(
        center: annotation.coordinate,
        radius: CLLocationDistance(viewModel.defaultMapRadius)
      )
    }
    
    mapView.addOverlay(overlayCircle)
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    guard let circleOverlay = overlay as? CirleOverlay else {
      return MKOverlayRenderer()
    }
    
    let circleView = MKCircleRenderer(overlay: circleOverlay)
    var color = UIColor.overlayNormal
    if
      let selected = viewModel.selectedTarget,
      selected == circleOverlay.target
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
    case .none:
      break
    }
  }
}
