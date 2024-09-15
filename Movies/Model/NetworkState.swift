//
//  State.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 14/09/24.
//

import Foundation

enum NetworkState {
    case loading
    case success(movies: [Movie])
    case failed(error: Error)
}
