//
//  Publisher+Extension.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import Combine

extension Publisher {
    func mapToOptional() -> AnyPublisher<Output?, Failure> {
        map { value -> Output? in value }.eraseToAnyPublisher()
    }
    
    func unwrap() -> AnyPublisher<Output, Failure> {
        compactMap { value -> Output in value }.eraseToAnyPublisher()
    }
}
