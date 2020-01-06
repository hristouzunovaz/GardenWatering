//
//  TankLevelIndicatorViewModel.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 7.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import Foundation
import Combine

class TankLevelIndicatorViewModel: ObservableObject, Identifiable {
    @Published var percentageFull: Double
    
    init(percentageFull: Double) {
        self.percentageFull = percentageFull
    }
}
