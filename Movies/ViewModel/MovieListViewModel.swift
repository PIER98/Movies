//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 09/09/24.
//

import Foundation
import RxSwift

class MovieListViewModel {
    
   private let movieService = MovieService()
   let movieSubject = PublishSubject<[Movie]>()

    func getMovies() {
        movieService.fetchData(completed: { [weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.movieSubject.onNext(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
