import Foundation
import Combine
import SwiftUI

class OrderListViewModel: ObservableObject {
    
    var orders = [OrderViewModel]()
    
    init() {
        fetchOrders()
    }
    
    func fetchOrders() {
        WebService().getAllOrders { (orders) in
            if let orders = orders {
                self.orders = orders.map(OrderViewModel.init)
            }
        }
    }
    
}

class OrderViewModel: Identifiable {
    
    var id = UUID()
    var order: Order
    
    init(order: Order) {
        self.order = order
    }
    
    // getters
    var name: String {
        return self.order.name
    }
    
    var size: String {
        return self.order.name
    }
    
    var coffeeName: String {
        return self.order.coffeeName
    }
    
    var total: Double {
        return self.order.total
    }
}
