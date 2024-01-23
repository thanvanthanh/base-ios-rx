//
//  ApiConnection.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 23/01/2024.
//

import Foundation
import Moya
import RxSwift

final class ApiConnection {
    
    static let share = ApiConnection()
    
    private let apiProvider: ApiProvider<MultiTarget>
    
    private init() {
        apiProvider = ApiProvider(plugins: [AuthPlugin()])
    }
    
}

extension ApiConnection {
    
    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<T> {
        return apiProvider.request(target: target).map(T.self)
    }
    
    func request(target: MultiTarget) -> Single<Int> {
        return apiProvider.request(target: target)
    }
    
    func request(target: MultiTarget) -> Single<String> {
        return apiProvider.request(target: target)
    }
    
    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<[T]> {
        return apiProvider.request(target: target).map([T].self)
    }
}
