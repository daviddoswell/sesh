//
//  SessionViewModel.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import Foundation
import FirebaseFirestore
import Combine

class SessionViewModel: ObservableObject {
  
  // MARK: - PROPERTIES
  @Published var sessions = [Session]()
  @Published var isLoading = false // Add loading state
  private var db = Firestore.firestore()
  
  // MARK: - FUNCTIONS
  
  func addSession(session: Session) {
    db.collection("sessions").addDocument(data: [
      "title": session.title,
      "description": session.description,
      "date": Timestamp(date: session.date)
    ]) { error in
      if let error = error {
        print("Error saving session to Firestore: \(error.localizedDescription)")
      } else {
        self.fetchSessions() // Refresh the sessions list after adding
      }
    }
  }
  
  func fetchSessions() {
    isLoading = true // Start loading
    db.collection("sessions").order(by: "date", descending: true).getDocuments { [weak self] (querySnapshot, error) in
      defer { self?.isLoading = false } // Stop loading once done
      if let error = error {
        print("Error fetching sessions from Firestore: \(error.localizedDescription)")
        return
      }
      
      guard let documents = querySnapshot?.documents else {
        print("No documents in 'sessions'")
        return
      }
      
      self?.sessions = documents.map { doc -> Session in
        let data = doc.data()
        let title = data["title"] as? String ?? "Session"
        let description = data["description"] as? String ?? "You Found Yourself."
        let date = (data["date"] as? Timestamp)?.dateValue() ?? Date() // Convert Timestamp to Date
        return Session(id: doc.documentID, title: title, description: description, date: date)
      }
      
      print("Sessions successfully fetched: \(self?.sessions ?? [])")
    }
  }
}
