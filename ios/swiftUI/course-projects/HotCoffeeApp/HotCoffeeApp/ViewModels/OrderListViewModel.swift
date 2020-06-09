//
//  OrderListViewModel.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class OrderListViewModel: ObservableObject {
    
    // var orders = [Order] // do not handle the order object itself
    @Published var orders = [OrderViewModel]()
    
    init() {
        fetchAllOrders()
    }
    
    func fetchAllOrders() {
        self.orders = CoreDataManager.shared.getAllOrders().map(OrderViewModel.init)
        print(self.orders)
    }
    
    func deleteOrder(_ orderVM: OrderViewModel) {
        CoreDataManager.shared.deleteOrder(name: orderVM.name)
        fetchAllOrders()
    }    
}


// Do not pass the actual CoreData object, make a wrapper for it
class OrderViewModel {
    var name = ""
    var type = ""
    init(order: Order) {
        self.name  = order.name!
        self.type = order.type!
    }
}
