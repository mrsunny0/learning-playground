//
//  AddOrderViewModel.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation

class AddOrderViewModel {
    var name: String = ""
    var type: String = ""
    
    func saveOrder() {
        CoreDataManager.shared.saveOrder(name: self.name, type: self.type)
    }
}
