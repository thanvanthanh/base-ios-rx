//
//  Enviroment.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 04/09/2023.
//

import Foundation

enum Enviroment {
    case staging
    case production
}

extension Enviroment {
    
    var baseURL: String { httpProtocol + hostName }
    
    private var httpProtocol: String { "https://" }
    
    var hostName: String {
        switch self {
        case .staging:
            return "api.github.com"
        case .production:
            return "api.github.com"
        }
    }
    
}
