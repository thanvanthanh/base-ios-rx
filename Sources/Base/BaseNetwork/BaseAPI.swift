//
//  BaseApi.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Alamofire
import Combine

class BaseAPI<T: TargetType> {
    typealias AnyPublisherResult<M> = AnyPublisher<M?, APIError>
    typealias FutureResult<M> = Future<M?, APIError>
}

extension BaseAPI {
    func fetchData<M: Decodable>(target: T,
                                 resonseseType: M.Type) -> AnyPublisherResult<M> {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        let params = self.buildParameters(task: target.task)
        let targetPath = self.buildTarget(target: target.path)
        let url = target.baseUrl + targetPath
        return FutureResult<M> { promise in
            AFNetworking.shared.request(url,
                                        method: method,
                                        parameters: params.0,
                                        encoding: params.1,
                                        headers: header,
                                        requestModifier: { $0.timeoutInterval = 20 })
            .validate(statusCode: 200..<300)
            .responseDecodable(of:M.self) { response in
                switch response.result {
                case let .success(data):
                    promise(.success(data))
                case let .failure(error):
                    guard !error.isTimeout else { return promise(.failure(.timeout))}
                    guard !error.isConnectedToTheInternet else { return promise(.failure(.noNetwork))}
                    return promise(.failure(.general))
                }
            }
        }.eraseToAnyPublisher()
    }
}


extension BaseAPI {
    func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    func buildTarget(target : RequestType) -> String {
        switch target {
        case let .requestPath(path):
            return path
        case let .queryParameters(query):
            return query
        }
    }
}
