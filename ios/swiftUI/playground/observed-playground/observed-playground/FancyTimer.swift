//
//  FancyTimer.swift
//  observed-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class FancyTimer: ObservableObject {
    
    @Published var value: Int = 0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.value += 1
        }
    }
}
