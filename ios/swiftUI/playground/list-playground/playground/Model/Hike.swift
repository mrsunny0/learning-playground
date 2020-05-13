//
//  Hike.swift
//  playground
//
//  Created by George Sun on 5/12/20.
//  Copyright © 2020 Nextiles. All rights reserved.
//

import Foundation

struct Hike: Identifiable {
    var id = UUID()
    let name: String
    let miles: Double
}

extension Hike {
    static func all() -> [Hike] {
        return [
            Hike(name: "HELLO", miles: 10),
            Hike(name: "OGD", miles: 20),
            Hike(name: "FE", miles: 100),
            Hike(name: "efE", miles: 100),
            Hike(name: "efff", miles: 100)
        ]
    }
}
