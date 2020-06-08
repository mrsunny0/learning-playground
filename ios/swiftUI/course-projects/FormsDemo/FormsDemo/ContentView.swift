//
//  ContentView.swift
//  FormsDemo
//
//  Created by George Sun on 6/8/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scheduled: Bool = false
    @State private var manuallyEnabled: Bool = false
    @State private var colorTemperature: CGFloat = 0.5
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("foaiewhfo aiwehfo aiwehfo iawehfo ihaewfo hwaeofio waefiho wiehfo waefh woaefhio waehfo whiefo ihweof hwaeofih waefihoawih ").padding(5).lineLimit(nil)) {
                    
                    Toggle(isOn: $scheduled) {
                        Text("Scheduled")
                    }
                    
                    HStack {
                        VStack {
                            Text("From")
                            Text("To")
                        }
                        Spacer()
                        
                        NavigationLink(destination: Text("Schedueld Settings")) {
                            VStack {
                                Text("Sunset").foregroundColor(.blue)
                                Text("Sunrise").foregroundColor(.blue)
                            }
                        }.fixedSize()
                    }
                        
                }
                
                Section(header: Text("")) {
                    Toggle(isOn: $manuallyEnabled) {
                        Text("Manually enable")
                    }
                }
                
                Section(header: Text("Color Temperature")) {
                    HStack {
                        Text("Less Warm")
                        Slider(value: $colorTemperature)
                        Text("More warm")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
