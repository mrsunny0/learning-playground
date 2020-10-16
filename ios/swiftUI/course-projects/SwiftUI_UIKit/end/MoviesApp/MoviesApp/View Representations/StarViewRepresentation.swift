//
//  StarViewRepresentation.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/20/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

struct StarViewRepresentation: UIViewRepresentable {
    
    @Binding var selected: Bool
    
    typealias UIViewType = StarView
    
    func makeUIView(context: UIViewRepresentableContext<StarViewRepresentation>) -> StarView {
        let starView = StarView()
        return starView
    }
    
    func updateUIView(_ uiView: StarView, context: UIViewRepresentableContext<StarViewRepresentation>) {
        uiView.selected = self.selected
    }
    
}
