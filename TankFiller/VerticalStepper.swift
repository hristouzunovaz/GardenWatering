//
//  VerticalStepper.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 8.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import SwiftUI

struct VerticalStepper: View {
    @ObservedObject var verticalStepperModel: VerticalStepperViewModel
    
    init(model: VerticalStepperViewModel) {
        self.verticalStepperModel = model
    }
    
    var body: some View {
        VStack {
            Text(verticalStepperModel.title)
            HStack {
                VStack {
                    Button(action: {
                        self.verticalStepperModel.handleButtons(in: .positive)
                    }) {
                        Text("+")
                            .font(.headline)
                    }
                    .padding()
                    .disabled(verticalStepperModel.currentValue == verticalStepperModel.maxValue)
                    
                    
                    Button(action: {
                        self.verticalStepperModel.handleButtons(in: .negative)
                    }) {
                        Text("-")
                            .font(.headline)
                    }
                    .padding()
                    .disabled(verticalStepperModel.currentValue == verticalStepperModel.minValue)
                }
                Text(String(format: "%.1f", Float(verticalStepperModel.currentValue)) + "l/s")
                    .lineLimit(1)
                    .frame(minWidth: 40, alignment: .leading)
            }
        }
    }
}

struct VerticalStepper_Previews: PreviewProvider {
    static var previews: some View {
        let model = VerticalStepperViewModel(title: "Some title", step: 0.2, maxValue: 10, minValue: 0, currentValue: 3)
        return VerticalStepper(model: model)
    }
}
