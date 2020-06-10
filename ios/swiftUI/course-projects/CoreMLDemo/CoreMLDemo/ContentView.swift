//
//  ContentView.swift
//  CoreMLDemo
//
//  Created by George Sun on 6/10/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let images = ["photo", "phone", "heart", "pen"]
    @State private var selectedImage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView([.horizontal]) {
                    HStack {
                        ForEach(images, id:\.self) { name in
                            Image(systemName: name)
                                .resizable()
                                .frame(width: 300, height: 300)
                                .padding()
                                .onTapGesture {
                                    self.selectedImage = name
                            }.border(Color.black, width: self.selectedImage == name ? 10 : 0)
                        }
                    }
                }
                Button("Detect") {
                    
                }.padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Text("Predictions will be placed here")
            }
            .navigationBarTitle("Core ML", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
