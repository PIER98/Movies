//
//  SearchMovieViewModel.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 22/09/24.
//

import Foundation
import RxSwift

class SearchMovieViewModel {
   private let movieService = MovieService()
   let stateSubject = PublishSubject<SearchState>()
    
   func searchMovies(query: String) {
        movieService.searchMovie(query: query) { result in
            switch result {
            case .success(let response):
                self.stateSubject.onNext(.success(movies: response.results))
            case .failure(let error):
                self.stateSubject.onNext(.failed(error: error))
            }
        }
    }
}

