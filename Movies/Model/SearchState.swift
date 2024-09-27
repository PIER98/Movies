//
//  SearchState.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 27/09/24.
//

import Foundation

enum SearchState {
    case success(movies: [Movie])
    case failed(error: Error)
}
