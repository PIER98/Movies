//
//  MoyaService.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 12/09/24.
//

import Foundation
import Moya

enum MoyaService: TargetType {

    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }
    
    var path: String {
        return "trending/movie/day"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
                
        let parameters: [String: Any] = [
            "api_key": Constants.apiKey
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
