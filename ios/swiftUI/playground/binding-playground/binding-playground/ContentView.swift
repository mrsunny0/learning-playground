//
//  ContentView.swift
//  binding-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let episode = Episode(name: "AAA", track: "CCC")
    
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            Text(self.episode.name)
                .foregroundColor(self.isPlaying ? .red : .blue)
            Text(self.episode.track)
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

struct PlayButton: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
            
        }) {
            Text("Play")
        }.padding(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
