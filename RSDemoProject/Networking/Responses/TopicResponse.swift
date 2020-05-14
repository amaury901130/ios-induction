//
//  BaseResponse.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

// this should be fixed in the backend
/*
 {
   "topics": [
     {
       "topic": {
         "id": 1,
         "label": "new topic",
         "icon": "/topic/icon/1/eb7bf9f2-62be-451c-af5b-5b41150eef1c.jpg"
       }
     },
     {
       "topic": {
         "id": 2,
         "label": "sample",
         "icon": "/topic/icon/2/78c08fab-02ce-41b9-8adf-1c2060c0d51f.jpg"
       }
     }
   ]
 }
 */
struct TopicResponse: Codable {
  var topic: Topic
  
  private enum CodingKeys: String, CodingKey {
    case topic
  }
}
