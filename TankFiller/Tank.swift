//
//  Tank.swift
//  TankFiller
//
//  Created by Hristo Uzunov on 6.09.19.
//  Copyright © 2019 SKLY. All rights reserved.
//

import SwiftUI
import Combine

enum FlowDirection {
    case input
    case output
}

class Tank: ObservableObject, Identifiable {
    
    let tankCapacity: Double = 300
    var inputFlowCapacity: Double = 0
    var outputFlowCapacity: Double = 0
    
    @Published var currentStorage: Double = 0 {
        
        didSet {
            
            
            if currentStorage < minStorageTreshold {
                isFillingUp = true
            }
            
            if currentStorage >= maxStorageTreshold {
                isFillingUp = false
            }
        }
    }
    
    @propertyWrapper struct StorageLevel {
        private var currentStorage: Double = 0
        let capacity: Double
        
        init(capacity: Double) {
            self.capacity = capacity
        }
        
        var wrappedValue: Double {
            get {
                return currentStorage
            }
            
            set {
                currentStorage = min(max(newValue, 0), capacity)
            }
        }
        
    }
    
    @Published var percentage: Double = 0
    
    private var maxStorageTreshold: Double {
        return tankCapacity * 0.95
    }
    
    private var minStorageTreshold: Double {
        return tankCapacity * 0.1
    }
    
    var isFillingUp = true
    
    @Published var seconds = 0
    
    private var cancellable: AnyCancellable?
    
    init() {
        startFilling()
    }
    
    func handleFlowChange(in direction: FlowDirection, value: Double) {
        switch direction {
        case .input:
            inputFlowCapacity = value
            
        case .output:
            outputFlowCapacity = value
        }
    }
    
    func counterReceived(_ value: Date) {
        seconds += 1
        currentStorage += netFlow()
        percentage = percentageFull()
    }
    
    private func netFlow() -> Double {
        let flow = (isFillingUp ? inputFlowCapacity : 0) - outputFlowCapacity
        return currentStorage + flow < 0 ? -currentStorage : flow
    }
    
    private func percentageFull() -> Double {
        return currentStorage / tankCapacity
    }
    
    func startFilling() {
        let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
        
        self.cancellable = timerPublisher.sink(receiveValue: counterReceived(_:))
    }
    
    func stopFilling() {
        cancellable?.cancel()
        cancellable = nil
    }
    
}
