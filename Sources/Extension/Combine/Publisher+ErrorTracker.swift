//
//  Publisher+ErrorTracker.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import Combine

final class ErrorIndicator {
    private struct ActivityToken<Source: Publisher> {
        let source: Source
        let errorAction: (Source.Failure) -> Void
        
        func asPublisher() -> AnyPublisher<Source.Output, Never> {
            source.handleEvents(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    errorAction(error)
                }
            })
            .catch { _ in Empty(completeImmediately: true) }
            .eraseToAnyPublisher()
        }
    }
    
    @Published
    private var relay: Error?
    private let lock = NSRecursiveLock()
    
    public var errors: AnyPublisher<Error, Never> {
        $relay.compactMap { $0 }.eraseToAnyPublisher()
    }
    
    public init() {}
    
    public func trackErrorOfPublisher<Source: Publisher>(source: Source) -> AnyPublisher<Source.Output, Never> {
        return ActivityToken(source: source) { error in
            self.lock.lock()
            self.relay = error
            self.lock.unlock()
        }.asPublisher()
    }
}

extension Publisher {
    func trackError(_ errorIndicator: ErrorIndicator) -> AnyPublisher<Self.Output, Never> {
        errorIndicator.trackErrorOfPublisher(source: self)
    }
}
