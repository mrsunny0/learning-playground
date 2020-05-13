//
//  ContentView.swift
//  CoffeeOrderingApp
//
//  Created by George Sun on 5/13/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var orderListViewModel = OrderListViewModel()
    
    var body: some View {
        OrderListView(orders: self.orderListViewModel.orders)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
