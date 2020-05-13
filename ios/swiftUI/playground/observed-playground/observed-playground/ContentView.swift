//
//  ContentView.swift
//  observed-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fancyTimer = FancyTimer()
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        VStack {
            Text("Hello \(fancyTimer.value)")
            Text("\(self.userSettings.score)")
            Button(action: {
                self.userSettings.score += 1
            }) {
                Text("Update Score")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
