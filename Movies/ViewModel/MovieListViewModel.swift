//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 09/09/24.
//

import Foundation

class MovieListViewModel {
    
   private let movieService = MovieService()

    func getMovies() {
        movieService.fetchData()
    }
}
