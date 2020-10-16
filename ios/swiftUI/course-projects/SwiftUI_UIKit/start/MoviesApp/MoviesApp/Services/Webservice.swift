//
//  Webservice.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/18/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

class Webservice {
    
    func loadMovies(url: String, completion: @escaping ([Movie]?) -> ()) {
        
        guard let url = URL(string: url) else {
            fatalError("URL is incorrect")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let moviesResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data)
            
            if let moviesResponse = moviesResponse {
                
                DispatchQueue.main.async {
                    completion(moviesResponse.search)
                }
            }
            
        }.resume()
        
    }
    
}
