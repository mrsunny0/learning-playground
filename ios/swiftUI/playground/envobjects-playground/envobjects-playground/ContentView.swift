//
//  ContentView.swift
//  envobjects-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // @ObservedObject var userSettings = UserSettings()
    @EnvironmentObject var userSettings: UserSettings
        
    var body: some View {
        VStack {
            Text("Score")
            Button("Update Score") {
                self.userSettings.score += 1
            }
            Text("\(self.userSettings.score)")
            // FancyScoreView(score: self.$userSettings.score)
            FancyScoreView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
    }
}
