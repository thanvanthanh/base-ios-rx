//
//  APIError.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Alamofire

enum NetworkErrorType: Int, Error {
    case UNAUTHORIZED = 401
    case INVALID_TOKEN = 403
}
