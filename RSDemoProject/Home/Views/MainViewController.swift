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
  var createTargetForm: UIViewController!
  
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
  
  @objc private func showCreateTargetForm() {
    createTargetForm = HomeRoutes.createTarget(viewModel.currentLocation!).screen
    createTargetForm.modalPresentationStyle = .overCurrentContext
    present(createTargetForm, animated: true, completion: nil)
  }

  private func addCurrentLocation(_ location: CLLocation) {
    mapView.center(location)
    mapView.addAnnotation(location, type: AnnotationType.selectedLocationRatio)
    mapView.addAnnotation(location)
  }
}

extension MainViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let customPointAnnotation = annotation as? PinAnnotation else {
      let annotationView = MKAnnotationView(
        annotation: annotation,
        reuseIdentifier: "temp"
      )
      
      return annotationView
    }

    let annotationView = MKAnnotationView(
      annotation: annotation,
      reuseIdentifier: customPointAnnotation.type.rawValue
    )

    annotationView.canShowCallout = true
    annotationView.image = customPointAnnotation.type.pinImage
    
    return annotationView
  }
}

extension MainViewController: MainViewModelDelegate {
  func didUpdateLocation(_ location: CLLocation) {
    addCurrentLocation(location)
  }
}
