//
//  ContentView.swift
//  state-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var tasks = Task.all()
    @State var toggle = false
    @State var name: String = ""
    
    private func addTask() {
        self.tasks.append(Task(name: "DO SOMETHING", onOff: false))
    }
    
    private func printName() {
        print(self.name)
    }
    
    var body: some View {
        VStack {
            
            Text(name)
            TextField("Enter some text", text: $name)
                .padding(12)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                self.printName()
            }) {
                Text("Show Name")
            }
            
//            List {
//
//                Toggle(isOn: $toggle) {
//                    Text("Toggle")
//                        .font(.subheadline)
//                }
//
//
//                Button(action: {
//                    self.addTask()
//                }) {
//                    Text("add task")
//                }
//
//                ForEach(tasks) { task in
//                    if task.onOff == self.toggle {
//                        HStack {
//                            Text(task.name)
//                                .lineLimit(nil)
//                        }
//                    }
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
