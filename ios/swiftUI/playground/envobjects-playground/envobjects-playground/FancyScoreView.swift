//
//  FancyScoreView.swift
//  envobjects-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct FancyScoreView: View {
    
    // @Binding var score: Int
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack {
            Text("\(self.userSettings.score)")
            Button("Increment SCore") {
                // self.score += 1
                self.userSettings.score += 1
                }.background(Color.green).padding()
        }.padding().background(Color.orange)
    }
}

struct FancyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FancyScoreView()
    }
}
