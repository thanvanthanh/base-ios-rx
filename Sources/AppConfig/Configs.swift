//
//  Configs.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 04/09/2023.
//

import Foundation

final class Configs {
    static let share = Configs()
    
    private init() {}
    
    var env: Enviroment {
        #if ENDPOINT_DEBUG
        return .staging
        #else
        return .production
        #endif
    }
}
