//
//  Configs.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 04/09/2023.
//

import Foundation
import RxSwift

final class Configs {
    static let shared = Configs()
    
    private init() {}
    
    var env: Enviroment {
        #if ENDPOINT_DEBUG
        return .staging
        #else
        return .production
        #endif
    }
    
    public var loggingAPIEnabled : Bool {
        #if ENDPOINT_DEBUG
        return true
        #else
        return false
        #endif
    }
    
    let apiTimeOut: Double = 30
    let loggingEnabled = true
}
