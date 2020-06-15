//
//  ContentView.swift
//  DataGroupList
//
//  Created by George Sun on 6/15/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let data = [
        [0,2,410],
        [2,3],
        [9,7,4,13]
    ]
    
    var body: some View {
        VStack {
            // conventional list control
            List(data, id: \.self) {i in
                Section(header: Text(String(i[0]))) {
                    ForEach(i, id: \.self) {j in
                        Text(String(j))
                    }
                }
            }.listStyle(GroupedListStyle())
        
            // stacked list
            List {
                ForEach(self.data, id: \.self) { i in
                    Section(header: Text(String(i[0])).font(.title)) {
                        ForEach(i, id: \.self) { j in
                            Text(String(j))
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
