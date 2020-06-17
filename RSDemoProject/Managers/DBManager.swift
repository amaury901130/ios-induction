//
//  DBManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
  var appDB: Realm?
  
  private static var shared: DBManager!
  static func sharedInstance() -> DBManager {
    if let instance = shared {
      return instance
    }
    
    shared = DBManager()
    return shared
  }
  
  init() {
    appDB = try? Realm()
  }
  
  func add(_ model: Object) {
    guard let db = appDB else {
      return
    }
    
    db.beginWrite()
    db.add(model)
    
    do {
      try db.commitWrite()
    } catch _ { }
  }
  
  func reset() {
    do {
        try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    } catch { }
  }
}

extension Object {
  func save() {
    DBManager.sharedInstance().add(self)
  }
}
