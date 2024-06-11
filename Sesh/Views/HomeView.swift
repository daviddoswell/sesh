//
//  HomeView.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import SwiftUI

struct HomeView: View {
  
  // MARK: - PROPERTIES
  
  @AppStorage("home") var isHomeViewActive: Bool = true
  
  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0.0
  @State private var isAnimating: Bool = false
  @State private var imageOffset: CGSize = .zero
  @State private var indicatorOpacity: Double = 1.0
  @State private var textTitle: String = "Sesh."
  
  let hapticFeedback = UINotificationFeedbackGenerator()
  
  
  // MARK: - BODY
  
  var body: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea()
      
      VStack(spacing: 20) {
        Spacer()
        
        // MARK: - HEADER
        
        VStack {
          Text(textTitle)
            .font(.system(size: 60, weight: .heavy, design: .rounded))
            .foregroundStyle(.white)
            .transition(.opacity)
          
          // MARK: - SUBHEADER

          
        } //: HEADER
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
        
        // MARK: - CENTER
        
        ZStack {
          HeartShapeView(shapeColor: .white, shapeOpacity: 0.2)
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(.easeInOut(duration: 1), value: imageOffset)
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
            .offset(x: imageOffset.width * 1.2, y: 0)
            .rotationEffect(.degrees(Double(imageOffset.width / 20)))
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if abs(imageOffset.width) <= 150 {
                    imageOffset = gesture.translation
                    
                    withAnimation(.linear(duration: 0.25)) {
                      indicatorOpacity = 0
                      
                      textTitle = "Session"
                    }
                  }
                }
                .onEnded { _ in
                  imageOffset = .zero
                  
                  withAnimation(.linear(duration: 0.25)) {
                    indicatorOpacity = 1
                    
                    textTitle = "Meditation"
                  }
                }
            ) // : GESTURE
            .animation(.easeOut(duration: 1), value: imageOffset)
          
        }
        
        Text("Just Takes a Minute")
        .font(.system(size: 30.0, weight: .heavy, design: .rounded))
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 10)
        
        Spacer()
        
        // MARK: - FOOTER
        
        ZStack {
          
          // 1. BACKGROUND (STATIC)
          
          Capsule()
            .fill(Color.white.opacity(0.2))
          Capsule()
            .fill(Color.white.opacity(0.2))
            .padding(8)
          
          // 2. CALL-TO-ACTION
          Text("Swipe Right")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .offset(x: 20)
          
          // 3. CAPSULE (DYNAMIC WIDTH)
          
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: buttonOffset + 80)
            
            Spacer()
            
          } //: HSTACK
          
          // 4. CIRCLE DRAGGABLE
          HStack {
            ZStack {
              Circle()
                .fill(Color("ColorRed"))
              Circle()
                .fill(.black.opacity(0.15))
                .padding(8)
              
            } //: ZSTACK
            .foregroundStyle(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged{ gesture in
                  if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                }
                .onEnded{ _ in
                  withAnimation(Animation.easeOut(duration: 0.4)) {
                    if buttonOffset > buttonWidth / 2 {
                      hapticFeedback.notificationOccurred(.success)
                      playSound(sound: "swipe", type: "mp3")
                      buttonOffset = buttonWidth - 80
                      isHomeViewActive = false
                    } else {
                      hapticFeedback.notificationOccurred(.warning)
                      buttonOffset = 0
                    }
                  }
                }
            ) //: GESTURE
            
            Spacer()
          } //: HSTACK
          
        } //: FOOTER
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
        
      } //: VSTACK
    } //: ZSTACK
    .onAppear(perform: {
      isAnimating = true
    })
    .preferredColorScheme(.dark)
  }
}

#Preview {
  HomeView()
}
