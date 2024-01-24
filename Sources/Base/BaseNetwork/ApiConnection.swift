//
//  ApiConnection.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 23/01/2024.
//

import Foundation
import Alamofire

import Alamofire

public protocol AppRequestConvertible: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding { get }
    var api: Api { get }
}
