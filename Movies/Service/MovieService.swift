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
    
    func fetchData(completed: @escaping (Result<TrendingMovieResponse, Error>)-> (Void)) {
        provider.rx.request(.getMovies).subscribe {response in
            switch response {
            case .success(let response):
                do {
                    let trendingMovieResponse = try response.map(TrendingMovieResponse.self, using: JSONDecoder())
                    completed(.success(trendingMovieResponse))
                }catch {
                    completed(.failure(error))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }.disposed(by: disposeBag)
    }
}
