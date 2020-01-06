//
//  TankLevelIndicator.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 7.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import SwiftUI
import Combine

struct TankLevelIndicator: View {
    @ObservedObject var percentageFull: TankLevelIndicatorViewModel
    
    init(percentageFull: TankLevelIndicatorViewModel) {
        self.percentageFull = percentageFull
    }
    
    var body: some View {
        ZStack {
            TankLevelFiller(percentage: percentageFull.percentageFull).fill(Color.blue)
            Rectangle().stroke(Color.black, lineWidth: 5)
            .shadow(radius: 3, y: 3)
        }
    }
}

struct TankLevelIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TankLevelIndicator(percentageFull: TankLevelIndicatorViewModel(percentageFull: 2))
    }
}

struct TankLevelFiller: Shape {
    var percentage: Double
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()
        
        let initialPointY = rect.height - (rect.height * CGFloat(percentage))
        
        p.addLines([CGPoint(x: 0, y: initialPointY), CGPoint(x: 0, y: rect.height), CGPoint(x: rect.width, y: rect.height), CGPoint(x: rect.width, y: initialPointY)])
        p.closeSubpath()
        return p
    }
    
    
}
