//
//  MovieService.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 09/09/24.
//

import Foundation
import Moya
import RxSwift

class MovieService {
    private let provider = MoyaProvider<MoyaService>()
    private let disposeBag = DisposeBag()
    
    func fetchData(completed: @escaping (Result<TrendingMovieResponse, Error>, NetworkState)-> (Void)) {
        provider.rx.request(.getMovies).subscribe {response in
            switch response {
            case .success(let response):
                do {
                    let trendingMovieResponse = try response.map(TrendingMovieResponse.self, using: JSONDecoder())
                    completed(.success(trendingMovieResponse), .success)
                }catch {
                    completed(.failure(error), .failed)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completed(.failure(error), .failed)
            }
        }.disposed(by: disposeBag)
    }
}
