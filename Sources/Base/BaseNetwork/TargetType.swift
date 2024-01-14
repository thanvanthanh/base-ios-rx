//
//  TargetType.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RequestType: Equatable {
    /// A request with no additional data.
    case requestPath(path: String)
    
    /// A request with query param
    case queryParameters(query: String)
}


enum Task {
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: URLEncoding)
}

protocol TargetType {
    var baseUrl: String { get }
    var path: RequestType { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var header: [String: String]? { get }
}
