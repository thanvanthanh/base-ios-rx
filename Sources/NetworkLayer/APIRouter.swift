//
//  APIRouter.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Alamofire

enum APIRouter {
    case search(username: String)
    case refreshToken(token: String)
}

extension APIRouter: AppRequestConvertible {
    
    var baseURL: URL {
        return URL(string: Configs.shared.env.baseURL)!
    }
    
    var api: Api {
        switch self {
            case .search:
                return .search
            case .refreshToken:
                return .none
        }
    }
    
    var path: String {
        switch self {
            case .search:
                return "/search/users"
            case .refreshToken:
                return "/auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .search:
                return .get
            case .refreshToken:
                return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
            case .search(let username):
                return ["q": username]
            case .refreshToken(let token):
                return ["token": token]
        }
    }
    
    
    var headers: HTTPHeaders {
        switch self {
            default :
                return HTTPHeaders.default
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .search:
                return URLEncoding.default
            case .refreshToken:
                return URLEncoding.httpBody
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        return try encoding.encode(request.asURLRequest(), with: parameters)
    }
    
}
