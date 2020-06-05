//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/20/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieDetailsView: View {
    
    @State private var selected: Bool = false
    
    let movie: Movie
    
    var body: some View {
        
        ZStack {
            Color.black
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            
            HStack {
                Spacer()
                StarViewRepresentation(selected: $selected)
                    .frame(width: 35, height: 35)
                    .padding()
            }
            
            
            URLImage(url: movie.poster)
            Text(movie.title)
                .foregroundColor(Color.white)
                .padding()
            
            Spacer()
            
        }
            
    }
        
    }
    
}

struct MovieDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let movie = Movie(title: "Batman", imdbId: "tt0372784", poster: "https://m.media-amazon.com/images/M/MV5BMTYwNjAyODIyMF5BMl5BanBnXkFtZTYwNDMwMDk2._V1_SX300.jpg")
        
        return MovieDetailsView(movie: movie)
        
    }
    
}
