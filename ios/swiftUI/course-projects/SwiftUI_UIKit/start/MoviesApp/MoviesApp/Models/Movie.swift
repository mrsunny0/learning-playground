//
//  Movie.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/18/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Codable {
    
    let title: String
    let imdbId: String
    let poster: String
    
    private enum CodingKeys: String,CodingKey {
        case title = "Title"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
    
}
