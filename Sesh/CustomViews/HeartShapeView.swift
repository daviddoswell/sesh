//
//  HeartShapeView.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import SwiftUI

struct HeartShapeView: View {
  
  // MARK: - PROPERTIES
  
  @State var shapeColor: Color
  @State var shapeOpacity: Double
  @State private var isAnimating: Bool = false
  
  var body: some View {
    ZStack {
      HeartShape()
        .fill(.white)
        .aspectRatio(1, contentMode: .fit)
        .padding(.all, 50)
        .opacity(0.2)
      
      ZStack {
        HeartShape()
          .fill(.white)
          .aspectRatio(1, contentMode: .fit)
          .opacity(0.2)
          .padding(.all, 6.25)
      } //: ZSTACK 2
      
    } //: ZSTACK 1
    .padding()
    .blur(radius: isAnimating ? 0 : 10)
    .opacity(isAnimating ? 1 : 0)
    .scaleEffect(isAnimating ? 1 : 0.5)
    .animation(.easeOut(duration: 1), value: isAnimating)
    .onAppear(perform: {
      isAnimating = true
    })
  }
}

#Preview {
  ZStack {
    Color.colorBlue
      .ignoresSafeArea()
    
    HeartShapeView(shapeColor: .white, shapeOpacity: 0.2)
  }
}
