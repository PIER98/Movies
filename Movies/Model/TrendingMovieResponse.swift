//
//  TrendingMovieResponse.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 09/09/24.
//

import Foundation


struct TrendingMovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let popularity: Float?
    let release_date: String?
    let vote_average: Float?
}
