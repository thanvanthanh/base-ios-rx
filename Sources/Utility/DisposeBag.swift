//
//  CancelBag.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Combine

final class DisposeBag {
    var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in disposeBag: DisposeBag) {
        disposeBag.subscriptions.insert(self)
    }
}
