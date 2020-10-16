//
//  ContentView.swift
//  Graphics-101
//
//  Created by Mohammad Azam on 6/22/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        BarGraph(reports: Report.all())
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
