//
//  SharedSequenceConvertibleType.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 23/01/2024.
//

import Foundation
import RxCocoa

extension SharedSequenceConvertibleType {
    
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    func unwrap<Result>() -> SharedSequence<SharingStrategy, Result> where Element == Result? {
        return compactMap { $0 }
    }
    
}

extension SharedSequenceConvertibleType where Element == Bool {
    
    func not() -> SharedSequence<SharingStrategy, Bool> {
        return self.map(!)
    }
    
}
