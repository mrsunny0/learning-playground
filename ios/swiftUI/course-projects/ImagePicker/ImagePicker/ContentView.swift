//
//  ContentView.swift
//  SwiftRecipes
//
//  Created by George Sun on 6/15/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    
    var body: some View {
        VStack {
            
            // if this is nil, it won't fire
            image?.resizable()
                .scaledToFit()
            
            // button to select an image 
            Button("Open Camera") {
                self.showImagePicker = true
            }.padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            
        }.sheet(isPresented: self.$showImagePicker) {
            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
