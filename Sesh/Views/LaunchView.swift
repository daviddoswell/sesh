//
//  LaunchView.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import SwiftUI

struct LaunchView: View {
  @Binding var isActive: Bool
  @State private var scale: CGFloat = 1.0
  var body: some View {
    ZStack {
      Color.colorBlue
        .ignoresSafeArea()
      
      Image("logo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(.white)
        .scaleEffect(scale)
        .frame(width: 100.0, height: 100.0)
        .onAppear {
          withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            self.scale = 1.2
          }
          
          // Delay transition
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
              self.isActive = false
            }
          }
        }
    }
  }
}


#Preview {
  LaunchView(isActive: .constant(true))
}

