//
//  ContentView.swift
//  ModalsDemo
//
//  Created by George Sun on 6/8/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showModal: Bool = false
    @State private var selectedFlag: String = ""
    @State private var country: String = ""
    let flags = [
        "feoafh",
        "feoafh",
        "aoihoa",
        "feiawhf"
    ]
    
    @State private var flagViewModel = FlagViewModel()
    
    var body: some View {
        List {
            
            Text(self.flagViewModel.country)
            
            ForEach(self.flags, id: \.self) { flag in
                HStack {
                    Text(flag)
                    Spacer()
                }.onTapGesture {
                    self.flagViewModel.flag = flag
                    self.flagViewModel.showModal.toggle()
                }
            }
        }.sheet(isPresented: self.$flagViewModel.showModal) {
            FlagDetailView(flagViewModel: self.$flagViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//            ForEach(0..<self.flags.count) { index in
//                HStack(alignment: .bottom) {
//                    Text(self.flags[index])
//                        .font(.largeTitle)
//                    Text("Flag \(index)")
//                }.onTapGesture {
//                    self.showModal.toggle()
//                    self.selectedFlag = self.flags[index]
//                }
//            }
