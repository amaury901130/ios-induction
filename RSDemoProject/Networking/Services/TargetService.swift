//
//  TargetService.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/18/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

class TargetService: BaseApiService<TargetResource> {
  static let shared = TargetService()
  
  func createTarget(
    title: String,
    area: Int,
    topic: Topic,
    latitude: Double,
    longitude: Double,
    success: @escaping (_ response: TargetMatch) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: .createTarget(
        title: title,
        area: area,
        topic: topic,
        latitude: latitude,
        longitude: longitude
      ),
      onSuccess: { (result: TargetMatch, _) -> Void in
        success(result)
    },
      onFailure: { error, _ in
        failure(error)
    })
  }
  
  func getTargets(
    success: @escaping (_ response: [Target]) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: .getTargets,
      at: "targets",
      onSuccess: { (result: [TargetResponse], _) -> Void in
        let targets = result.map { $0.target }
        success(targets)
    },
      onFailure: { error, _ in
        failure(error)
    })
  }
  
  func deleteTarget(
    target: Target,
    success: @escaping () -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: .destroyTarget(target.id),
      onSuccess: { _ in
        success()
    },
      onFailure: { error, _ in
        failure(error)
    })
  }
}
