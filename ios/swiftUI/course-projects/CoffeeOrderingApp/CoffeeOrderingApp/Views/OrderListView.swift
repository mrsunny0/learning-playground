//
//  OrderListView.swift
//  CoffeeOrderingApp
//
//  Created by George Sun on 5/13/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    
    let orders: [OrderViewModel]
    
    init(orders: [OrderViewModel]) {
        self.orders = orders
    }
    
    var body: some View {
        List {
            ForEach(self.orders, id:\.id) { order in
                HStack {
                    Image(order.coffeeName)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    
                    VStack {
                        Text(order.name)
                            .font(.title)
                            .padding([.leading, .bottom], 10)
                        
                        HStack {
                            Text(order.coffeeName)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.init(.gray))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Text(order.size)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.init(.blue))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: [OrderViewModel(order: Order(name: "AAA", coffeeName: "BBB", size: "CCC", total: 100.0))])
    }
}
