//
//  MoyaService.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 12/09/24.
//

import Foundation
import Moya

enum MoyaService: TargetType {

    case getMovies
    case searchMovies(query: String)
    
    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "3/trending/movie/day"
        case .searchMovies(query:_):
           return "3/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        case .searchMovies(query:_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovies:
            let parameters: [String: Any] = [
                "api_key": Constants.apiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .searchMovies(query: let query):
            let parameters: [String: Any] = [
                "query": query,
                "api_key": Constants.apiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
