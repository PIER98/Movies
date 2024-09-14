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
   let isLoading = PublishSubject<NetworkState>()

    func getMovies() {
        movieService.fetchData(completed: { [weak self] result,state  in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.isLoading.onNext(state)
                self?.movieSubject.onNext(movies)
                print("Success")
            case .failure(let error):
                print(error.localizedDescription)
                self?.isLoading.onNext(state)
                print("Failed")
            }
        })
    }
}
