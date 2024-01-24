//
//  BaseViewModel.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import RxSwift
import RxRelay
import Moya
import NSObject_Rx

class BaseViewModel: NSObject {
    
    // Track Error
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    
    // Track Loading
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    override init() {
        super.init()
        
        error
            .asObservable()
            .subscribe(onNext: { (error) in
                if let error = error as? AppError {
                    LogError(error.localizedDescription)
                } else if let error = error as? RxSwift.RxError {
                    switch error {
                        case .timeout:
                            LogError("Time Out")
                        default:
                            return
                    }
                } else if let error = error as? Moya.MoyaError {
                    switch error {
                        case .objectMapping(_, let response), .jsonMapping(let response), .statusCode(let response):
                            if let errorResponse = try? response.map(ErrorResponse.self),
                               let errorDesc = errorResponse.errorDescription {
                                LogError(errorDesc)
                            } else {
                            }
                        default:
                            return
                    }
                } else {
                    print(error.localizedDescription)
                }
            })
            .disposed(by: rx.disposeBag)
    }
}
