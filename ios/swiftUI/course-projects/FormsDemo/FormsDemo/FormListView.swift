//
//  FormListView.swift
//  FormsDemo
//
//  Created by George Sun on 6/8/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct FormListView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Show Previs")
                        Spacer()
                        NavigationLink(destination: Text(""))  {
                            Text("Always").foregroundColor(.gray)
                        }.fixedSize()
                    }
                }
                
                Section(header: Text("feoaihfoeaihfo aiwehfo aih")) {
                    NavigationLink(destination: Text("")) {
                        Text("Siri suggestions text")
                    }
                }
                
                Section(header: VStack(alignment: .leading) {
                    Text("First line")
                    Text("Second line")
                }) {
                    ForEach(Range(1...10)) { index in
                        NavigationLink(destination: Text("")) {
                            Text("WAO")
                        }
                    }
                }
            }
            
            .navigationBarTitle("HELLO", displayMode: .inline)
        }
    }
}

struct FormListView_Previews: PreviewProvider {
    static var previews: some View {
        FormListView()
    }
}
