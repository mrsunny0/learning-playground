//
//  NetworkManager.swift
//  HackerNews
//
//  Created by George Sun on 4/26/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation

let frontPageUrl = "http://hn.algolia.com/api/v1/search?tags=front_page"

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: frontPageUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.sync {
                                self.posts = results.hits                                
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            
            // start task
            task.resume()
        }
    }
}
