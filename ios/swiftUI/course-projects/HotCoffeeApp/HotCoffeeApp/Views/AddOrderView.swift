//
//  AddOrderView.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct AddOrderView: View {
    
    @State var addOrderVM = AddOrderViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    TextField("Enter name", text: $addOrderVM.name)
                    Picker(selection: self.$addOrderVM.type, label: Text("")) {
                        Text("Cappuccino").tag("cap")
                        Text("Regular").tag("reg")
                        Text("Expresso").tag("ex")
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button("Place Order") {
                        self.addOrderVM.saveOrder()
                        self.isPresented.toggle()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                }
            }.padding()
            
            .navigationBarTitle(Text("Add Order"))
        }
    }
}

struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(isPresented: .constant(true))
    }
}
