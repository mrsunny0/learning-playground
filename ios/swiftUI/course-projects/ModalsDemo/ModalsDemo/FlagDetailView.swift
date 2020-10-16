//
//  FlagDetailView.swift
//  ModalsDemo
//
//  Created by George Sun on 6/8/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct FlagDetailView: View {
    
//    let flag: String
//    @Binding var country: String
//    @Binding var showModal: Bool
    
    @Binding var flagViewModel: FlagViewModel
    
    var body: some View {
        VStack {
            Text(self.flagViewModel.flag)
            TextField("Placeholder", text: self.$flagViewModel.country)
                .padding()
                .fixedSize()
            Button("Submit") {
                print("I GOT CLICKED")
                self.flagViewModel.showModal = false
            }
        }
    }
}

struct FlagDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlagDetailView(flagViewModel: .constant(FlagViewModel()))
    }
}
