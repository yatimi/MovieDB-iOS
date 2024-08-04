//
//  API.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Alamofire

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var URLConvertible: String { get }
    var headers: HTTPHeaders? { get }
    var parameterEncoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension API {
    
    var parameters: Parameters? { nil }
    
    var headers: HTTPHeaders? { nil }
    
    var parameterEncoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var URLConvertible: String {
        baseURL + path
    }
    
}
