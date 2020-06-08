//
//  ContentView.swift
//  GesturesDemo
//
//  Created by George Sun on 6/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapped: Bool = false
    @State private var cardDragState: CGSize = CGSize.zero
    @State private var cardRotate: Angle = Angle.zero
    
    var body: some View {
        Card(tapped: self.tapped)
            .animation(.spring())
            .offset(y: self.cardDragState.height)
            .rotationEffect(self.cardRotate)
            
            //rotate
            .gesture(RotationGesture()
                .onChanged({ value in
                    self.cardRotate = Angle(degrees: value.degrees)
                }))
            
            // drag
            .gesture(DragGesture()
                .onChanged({ value in
                    self.cardDragState = value.translation
                })
                .onEnded({ value in
                    self.cardDragState = CGSize.zero
                }))
            
            // tap
            .gesture(TapGesture(count: 1)
                .onEnded({ () in
                    self.tapped.toggle()
                    print("TAPPED")
                })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
