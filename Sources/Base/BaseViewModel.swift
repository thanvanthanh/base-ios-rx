//
//  BaseViewModel.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import Combine

class BaseViewModel: NSObject {
    
    // Track Error
    let errorIndicator = ErrorIndicator()
    lazy var errorPublisher = errorIndicator.errors.eraseToAnyPublisher()
    
    // Track Loading
    let activityIndicator = ActivityIndicator()
    lazy var loadingPublisher = activityIndicator.loading.eraseToAnyPublisher()
        
    override init() {
        super.init()
    }
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, _ disposeBag: DisposeBag) -> Output
}
