//
//  Task.swift
//  state-playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    let name: String
    let onOff: Bool
}

extension Task {
    static func all() -> [Task] {
        return [
            Task(name: "A", onOff: true),
            Task(name: "B", onOff: true),
            Task(name: "C", onOff: false),
            Task(name: "D", onOff: false),
            Task(name: "E", onOff: true),
        ]
    }
}
