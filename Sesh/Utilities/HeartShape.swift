//
//  HeartShape.swift
//  Sesh
//
//  Created by David Doswell on 6/10/24.
//

import SwiftUI

struct HeartShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let width = rect.width
    let height = rect.height
    
    // Calculate the center of the top lobes
    let lobeCenter = width / 2
    let lobeRadius = width / 3.5
    
    // Start at the bottom center of the heart
    path.move(to: CGPoint(x: lobeCenter, y: height))
    
    // Left bottom curve
    path.addCurve(to: CGPoint(x: 0, y: lobeRadius),
                  control1: CGPoint(x: lobeCenter - lobeRadius, y: height * 3 / 4),
                  control2: CGPoint(x: 0, y: height / 2))
    
    // Top left lobe
    path.addArc(center: CGPoint(x: lobeRadius, y: lobeRadius),
                radius: lobeRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 0),
                clockwise: false)
    
    // Top right lobe
    path.addArc(center: CGPoint(x: width - lobeRadius, y: lobeRadius),
                radius: lobeRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 0),
                clockwise: false)
    
    // Right bottom curve
    path.addCurve(to: CGPoint(x: lobeCenter, y: height),
                  control1: CGPoint(x: width, y: height / 2),
                  control2: CGPoint(x: lobeCenter + lobeRadius, y: height * 3 / 4))
    
    return path
  }
}

