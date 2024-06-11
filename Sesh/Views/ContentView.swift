//
//  ContentView.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: - PROPERTIES
  
  @AppStorage("home") var isHomeViewActive: Bool = true
  @State private var isLaunchScreenActive = true
  @State private var homeViewOpacity = 0.0
  
  // MARK: - BODY
  
  var body: some View {
    ZStack {
      if isHomeViewActive {
        HomeView()
          .opacity(homeViewOpacity)
      } else {
        MeditationView()
          .opacity(homeViewOpacity)
      }
      
      // MARK: - LAUNCH SCREEN OVERLAY
      
      if isLaunchScreenActive {
        LaunchView(isActive: $isLaunchScreenActive)
          .transition(.opacity)
          .zIndex(1)
      }
    }
    .onAppear {
      self.homeViewOpacity = 0.0
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        
        // MARK: - ANIMATION
        
        withAnimation(.easeOut(duration: 1.0)) {
          self.isLaunchScreenActive = false
          self.homeViewOpacity = 1.0 // Ensure both HomeView and MeditationView fade in smoothly
        }
      }
    }
  }
}

#Preview {
  ContentView()
}

