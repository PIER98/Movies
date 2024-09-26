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
   let movieSubject = PublishSubject<TrendingMovieResponse>()
    
    func searchMovies(query: String) {
        movieService.searchMovie(query: query) { result in
            switch result {
            case .success(let response):
                self.movieSubject.onNext(response)
                print(response.results)
            case .failure(let error):
                self.movieSubject.onError(error)
                print(error.localizedDescription)
            }
        }
    }
}

