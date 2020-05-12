//
//  PostData.swift
//  HackerNews
//
//  Created by George Sun on 4/26/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    let title: String
    let points: Int
    let url: String?
    let objectID: String
    
    // create computed property
    var id: String {
        return objectID
    }
}
