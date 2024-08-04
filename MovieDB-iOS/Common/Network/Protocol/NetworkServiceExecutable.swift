//
//  NetworkServiceExecutable.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Alamofire

protocol NetworkServiceExecutable {
    
    @discardableResult
    func execute<Model: Codable, Target: API>(
        target: Target,
        completionHandler: @escaping (Result<Model, MoviesNetworkError>) -> Void
    ) -> DataRequest?
    
}
