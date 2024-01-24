//
//  APIError.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation

public enum APIError: Error {
    case noInternetConnection
    case actionAlreadyPerforming
    case networkError(api: Api, error: Error, data: Data?)
    case none
}
