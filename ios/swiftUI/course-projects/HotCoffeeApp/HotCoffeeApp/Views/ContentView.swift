//
//  ContentView.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var orderListVM: OrderListViewModel
    @State private var isPresented: Bool = false
    
    init() {
        self.orderListVM = OrderListViewModel()
    } // this is like onCreate for android
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let orderVM = self.orderListVM.orders[index]
            self.orderListVM.deleteOrder(orderVM)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.orderListVM.orders, id: \.name) { order in
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        Text(order.name)
                            .font(.largeTitle)
                            .padding([.leading], 10)
                        Text(order.type)
                    }
                }.onDelete(perform: delete)
            }
                
            .sheet(isPresented: $isPresented, onDismiss: {
                print("Dismiss")
                self.orderListVM.fetchAllOrders() // update frontend with new content
            }, content: {
                AddOrderView(isPresented: self.$isPresented)
            })
                
            .navigationBarTitle("Orders")
            .navigationBarItems(trailing: Button("add new order") {
                print("HELLO")
                self.isPresented.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
