//
//  ContentView.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 6.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var model: Tank
    let inputModel: VerticalStepperViewModel
    let outputModel: VerticalStepperViewModel
    
    let currentTankHeight: CGFloat = 607
    
    private var cancellables = Set<AnyCancellable>()
    
    init(model: Tank = Tank()) {
        self.model = model
        self.inputModel = VerticalStepperViewModel(title: "Inflow", step: 0.2, maxValue: 10, minValue: 0)
        self.outputModel = VerticalStepperViewModel(title: "Outflow", step: 0.2, maxValue: 9, minValue: 0)
        
        self.inputModel.$currentValue.assign(to: \.inputFlowCapacity, on: self.model)
            .store(in: &cancellables)
        self.outputModel.$currentValue.assign(to: \.outputFlowCapacity, on: self.model)
        .store(in: &cancellables)
            
    }
    
    var body: some View {
        VStack {
            Text("Current water volume: \(Int(model.currentStorage))l")
            HStack(spacing: 16) {
                TankLevelIndicator(percentageFull: TankLevelIndicatorViewModel(percentageFull: model.percentage))
                .padding(10)
                .frame(width: 0.7 * UIScreen.main.bounds.width, height: nil, alignment: .leading)
                Text(String(format: "%.2f", model.percentage * 100) + "%")
                    .baselineOffset(-(currentTankHeight / 2) + (currentTankHeight * CGFloat(model.percentage)))
                    .lineLimit(1)
                    .frame(minWidth: 80, alignment: .leading)
            }
            
            HStack {
                VerticalStepper(model: inputModel)
                VerticalStepper(model: outputModel)
            }
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Tank()
        model.currentStorage = 100
        return ContentView(model: model)
    }
}
