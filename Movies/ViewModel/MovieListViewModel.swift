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
   let stateSubject = BehaviorSubject<NetworkState>(value:.loading )

    func getMovies() {
        movieService.fetchData(completed: { [weak self] result  in
            switch result {
            case .success(let response):
                self?.stateSubject.onNext(.success(movies: response.results))
            case .failure(let error):
                print(error.localizedDescription)
                self?.stateSubject.onNext(.failed(error: error))
            }
        })
    }
}
