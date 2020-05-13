//
//  ContentView.swift
//  playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let hikes = Hike.all()
    
    var body: some View {
        
        NavigationView {
//            List(hikes) { hike in
//                NavigationLink(destination: HikeDetail(hike: hike)) {
//                    Row(hike: hike)
//                }
//            }
                
            return List {
                // rows
                ForEach(0..<5) { index in
                    HStack {
                        
                        // columns
                        ForEach(0..<4) { _ in
                            Text("HELLO")
                        }
                    }
                }
            }
        .navigationBarTitle("Title")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Row: View {
    
    let hike: Hike
    
    var body: some View {
        HStack {
            Text(hike.name)
            Text(String(format: "%.0f", hike.miles))
        }
    }
}
