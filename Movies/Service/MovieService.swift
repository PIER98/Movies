//
//  MovieService.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 09/09/24.
//

import Foundation

class MovieService {
    private let baseUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key=aadeed15a6c1e2f021251142b1339190"
    
    func fetchData() {
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { data,_, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                print("🤖",result.results.count)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
