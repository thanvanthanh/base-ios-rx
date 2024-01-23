//
//  Observable+Operators.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 23/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<Result>() -> Observable<Result> where Element == Result? {
        return self.compactMap { $0 }
    }
    
}

extension ObservableType where Element == Bool {
    
    func not() -> Observable<Bool> {
        return self.map(!)
    }
    
}
