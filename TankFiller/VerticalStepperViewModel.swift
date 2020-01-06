//
//  VerticalStepperViewModel.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 8.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import Foundation
import Combine

enum Direction {
    case positive
    case negative
}

class VerticalStepperViewModel: ObservableObject, Identifiable {
    var title: String
    var step: Double
    var maxValue: Double
    var minValue: Double
    @Published var currentValue: Double
    
    init(title: String, step: Double, maxValue: Double, minValue: Double, currentValue: Double = 0) {
        self.title = title
        self.step = step
        self.maxValue = maxValue
        self.minValue = minValue
        self.currentValue = currentValue
    }
    
    func handleButtons(in direction: Direction) {
        switch direction {
        case .positive:
            if currentValue + step < maxValue {
                currentValue += step
            }
            else {
                currentValue = maxValue
            }
            
        case .negative:
            if currentValue - step > minValue {
                currentValue -= step
            }
            else {
                currentValue = minValue
            }
            
        }
    }
    
    
}
