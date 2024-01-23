//
//  APIRouter.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Moya

enum APIRouter {
    case search(username: String)
    case refreshToken(token: String)
}

extension APIRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: Configs.share.env.baseURL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/users"
        case .refreshToken:
            return "/auth/refresh"
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        case .refreshToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .search(username):
            return .requestParameters(parameters: ["q": username], encoding: URLEncoding.default)
        case let .refreshToken(token):
            return .requestParameters(parameters: ["refresh_token": token], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default :
            return ["Content-Type":"application/json",
                    "accept":"application/json"]
        }
    }
    
    
}
