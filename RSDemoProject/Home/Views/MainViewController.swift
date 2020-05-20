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
  
  private func showModalForSelectedTarget() {
    //todo...
  }
  
  @objc private func showCreateTargetForm() {
    navigateTo(
      HomeRoutes.createTarget,
      withTransition: .modal(presentationStyle: .overCurrentContext)
    )
  }
  
  private func addCurrentLocation(_ location: CLLocation) {
    mapView.center(location)
    mapView.addAnnotation(PinAnnotation(location))
  }
  
  func loadUserTargets() {
    guard let targets = viewModel.userTargets else {
      return
    }
    
    targets.forEach { target in
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
    
    var radius: Int
    
    switch customPointAnnotation.pinType {
    case .target(let target):
      radius = target.radius
    default:
      radius = viewModel.defaultMapRadius
    }
    
    let overlayCircle = MKCircle(
      center: annotation.coordinate,
      radius: CLLocationDistance(radius)
    )

    mapView.addOverlay(overlayCircle)
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKCircle {
      let circleView = MKCircleRenderer(overlay: overlay)
      circleView.fillColor = UIColor.mapAnnotationRadius
      return circleView
    }

    return MKOverlayRenderer()
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard
      let customAnnotation = view as? ImageAnnotationView
      else {
        return
    }
    
    switch customAnnotation.pinType {
    case .target(let target):
      viewModel.selectedTarget = target
    default:
      break
    }
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
    case .didUpdateLocation:
      guard let location = viewModel.currentLocation else {
        return
      }
      
      addCurrentLocation(location)
    case .didLoadTargets:
      loadUserTargets()
    case .didTargetSelect:
      showModalForSelectedTarget()
    case .none:
      break
    }
  }
}
