//
//  ImageDetectionViewModel.swift
//  CoreMLDemo
//
//  Created by George Sun on 6/10/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageDetectionViewModel: ObservableObject {
    var name: String = ""
    var manager: ImageDetectionManager
    @Published var predictionLabel: String = ""
    
    init(manager: ImageDetectionManager) {
        self.manager = manager
    }
    
    func detect(_ name: String) {
        // resize image
        
        // detect image
        
        // update prediction label
    }
}
