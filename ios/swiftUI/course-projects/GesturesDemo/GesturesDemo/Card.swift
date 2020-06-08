//
//  Card.swift
//  GesturesDemo
//
//  Created by George Sun on 6/8/20.
//

import Foundation
import SwiftUI

struct Card: View {
    
    let tapped: Bool
    @State private var scale: Double = 1
    
    var body: some View {
        VStack {
            
            Image(systemName: "photo")
                .resizable()
//                .scale Effect(self.scale)
                .frame(width: 300, height: 300)
//                .gesture(MagnificationGesture()
//                    .onChanged({ value in
//                        self.scale = value.magnitude
//                    })
//                )
            
            
            Text("Card")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(self.tapped ? Color.orange: Color.purple)
        .cornerRadius(30)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(tapped: false)
    }
}
