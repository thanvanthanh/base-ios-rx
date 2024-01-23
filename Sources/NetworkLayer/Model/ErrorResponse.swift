//
//  ErrorResponse.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 23/01/2024.
//

import Foundation

class ErrorResponse: Codable {
    // var errorCode: Int?
    var errorDescription: String?
}

class BaseErrorResponse: Codable {
    var errorCode: Int?
    var message: String?
    
    var errors: [ErrorResponse]?
}
extension ErrorResponse: CustomStringConvertible {
    var description: String {
        return """
        errorDescription: \(errorDescription ?? "")
        """
    }
}
