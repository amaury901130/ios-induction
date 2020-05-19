//
//  TargetService.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/18/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Moya

class TargetService: BaseApiService<TargetResource>  {
  static let shared = TargetService()
  
  func createTarget(
    title: String,
    area: Int,
    topic: Topic,
    latitude: Double,
    longitude: Double,
    success: @escaping (_ response: CreateTargetResponse) -> Void,
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
      onSuccess: { (result: CreateTargetResponse, _) -> Void in
        success(result)
    },
      onFailure: { error, _ in
        failure(error)
    })
  }
}