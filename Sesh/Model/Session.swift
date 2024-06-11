//
//  Session.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import Foundation

struct Session: Identifiable {
  
  // MARK: - PROPERTIES
  
  var id: String = UUID().uuidString
  var title: String
  var description: String = "You Found Yourself."
  var date: Date
}
