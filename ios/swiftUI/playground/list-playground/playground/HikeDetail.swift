//
//  HikeDetail.swift
//  playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct HikeDetail: View {
    
    let hike: Hike
    @State private var zoomed: Bool = false
    
    var body: some View {
        VStack {
            Text(hike.name)
            Spacer()
                .frame(height: 50)
            Text(String(format: "%.2f", hike.miles))
                .font(.system(size: self.zoomed ? 100 : 10))
                .onTapGesture {
                    withAnimation {
                        self.zoomed.toggle()
                    }
            }
        }.navigationBarTitle(Text(hike.name), displayMode: .inline)
    }
}

struct HikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetail(hike: Hike(name: "AAA", miles: 200))
    }
}
