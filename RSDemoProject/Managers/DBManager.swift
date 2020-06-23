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
  private var appDB: Realm!
  static let sharedInstance = DBManager()
  
  init() {
    do {
      let documentDirectory = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
      )
      
      let url = documentDirectory.appendingPathComponent("targetDb.realm")
      appDB = try? Realm(fileURL: url)
    } catch { }
  }

  func add(_ model: [Object]) {
    guard let db = appDB else {
      return
    }
    
    db.beginWrite()
    db.add(model, update: .modified)
    
    do {
      try db.commitWrite()
    } catch { }
  }
  
  func reset() {
    guard let dbFile = Realm.Configuration.defaultConfiguration.fileURL else {
      return
    }
    
    do {
      try FileManager.default.removeItem(at: dbFile)
    } catch { }
  }
  
  func save(_ model: Object) {
    add([model])
  }
  
  func save(_ model: [Object]) {
    add(model)
  }
  
  func getObjects<Element: Object>(_ type: Element.Type) -> Results<Element> {
    appDB.objects(type)
  }
}
