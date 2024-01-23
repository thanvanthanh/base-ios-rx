//
//  BaseApi.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 28/08/2023.
//

import Foundation
import Moya
import RxSwift

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    //private let repo = AppRepository()
    
    init(plugins: [PluginType]) {
        var plugins = plugins
        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())
        if Configs.share.loggingEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        super.init(plugins: plugins)
    }
    
    func request(target: Target) -> Single<Response> {
        return connectedToInternet()
            .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            .processInternetConnectionError()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            })
            .processResponse(target: target)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    func request(target: Target) -> Single<Int> {
        return connectedToInternet()
            .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            .processInternetConnectionError()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            })
            .processResponse(target: target)
            .map({ $0.statusCode })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    func request(target: Target) -> Single<String> {
        return connectedToInternet()
            .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            .processInternetConnectionError()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            })
            .mapString()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}

extension Observable where Element == Response {
    func processErrorResponse(_ response: Response, target: TargetType) {
        // handle error message
        guard response.statusCode > 200,
              let errorResponse = try? response.map(BaseErrorResponse.self) else { return }
        // message
        let processMessageSuccess = processMessage(errorResponse.message)
        if !processMessageSuccess {
            // errorDescription
            processMessage(errorResponse.errors?.first?.errorDescription)
        }
    }
    
    @discardableResult
    func processMessage(_ message: String?) -> Bool {
        guard let message = message, !message.isEmpty else { return false }
        
        let splittedMessage = message.split(separator: "-")
        guard splittedMessage.count == 2 else { return false }
        
        return true
    }
}

extension Observable where Element == Bool {
    func processInternetConnectionError() -> Observable<Bool> {
        return self.do(onNext: { (result) in
            if result == false {
//                AppHelper.showMessage(title: R.string.localizable.server_internet_connection_error())
            }
        })
    }
}

extension Observable where Element == Response {
    func processResponse(target: TargetType) -> Observable<Response> {
        self.flatMapLatest({ [weak self] response -> Single<Response> in
            switch response.statusCode {
            case NetworkErrorType.UNAUTHORIZED.rawValue:
                return .error(NetworkErrorType.UNAUTHORIZED)
            case NetworkErrorType.INVALID_TOKEN.rawValue:
                return .error(NetworkErrorType.INVALID_TOKEN)
            default:
                self?.processErrorResponse(response, target: target)
                return .just(response)
            }
        })
        .catchError({ [weak self] (error) -> Observable<Response> in
            guard let self = self else { return .empty() }
            if case NetworkErrorType.UNAUTHORIZED = error {
                // TODO: handle force logout
                return .empty()
            } else if case NetworkErrorType.INVALID_TOKEN = error {
                // TODO: handle force logout
                return .empty()
            } else {
                return .error(error)
            }
        })
    }
}
