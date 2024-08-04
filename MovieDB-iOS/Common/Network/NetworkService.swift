//
//  NetworkService.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation
import Alamofire

final class NetworkService: NetworkServiceExecutable {
    
    // MARK: - Properties
    
    private(set) var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private var currentRequest: DataRequest?
    private let networkMonitor = NetworkMonitor.shared
    
    // MARK: - Init
    
    init() {
        networkMonitor.startMonitoring()
    }
    
    deinit {
        networkMonitor.stopMonitoring()
    }
    
    // MARK: - Requests
    
    func execute<Model: Codable, Target: API>(
        target: Target,
        completionHandler: @escaping (Result<Model, MoviesNetworkError>) -> Void
    ) -> DataRequest? {
        guard networkMonitor.isConnected else {
            completionHandler(.failure(MoviesNetworkError.networkUnavailable))
            return nil
        }
        
        return request(target: target) { result in
            switch result {
            case .success(let data):
                if let decodeModel = self.decode(Model.self, in: data) {
                    completionHandler(.success(decodeModel))
                } else {
                    completionHandler(.failure(MoviesNetworkError.couldNotDecode))
                }
            case .failure(let error):
                completionHandler(.failure(MoviesNetworkError.unexpectedError(error)))
            }
        }
    }
    
    // MARK: - Help methods
    
    private func request<Target: API>(
        target: Target,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) -> DataRequest? {
        return AF.request(target.URLConvertible,
                          method: target.method,
                          parameters: target.parameters,
                          encoding: target.parameterEncoding,
                          headers: target.headers)
        .cacheResponse(using: .doNotCache)
        .validate()
        .responseData { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case let .success(data):
                completionHandler(.success(data))
            case let .failure(error):
                let statusCode: Int? = response.response?.statusCode
                let error = self.handleError(from: statusCode, error: error)
                completionHandler(.failure(error))
            }
        }
    }
    
    // MARK: - Decoder
    
    private func decode<T: Codable>(_ type: T.Type, in responseData: (Data)) -> T? {
        try? decoder.decode(T.self, from: responseData)
    }
    
    // MARK: - Help methods
    
    private func handleError(from statusCode: Int?, error: AFError) -> Error {
        if let statusCode = statusCode {
            switch statusCode {
            case 404:
                return MoviesNetworkError.pageIsNotAvailable
            default:
                return MoviesNetworkError.invalidStatusCode(statusCode)
            }
        } else {
            return MoviesNetworkError.unexpectedError(error)
        }
    }
    
}
