//
//  RequestInterceptor.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 31/08/2023.
//

import Foundation
import Alamofire
import Combine

protocol RefreshTokenRequestable: AnyObject {
    func refreshToken(_ token: String) -> AnyPublisher<AuthorizeModel?, APIError>
}

final class RefreshTokenRequest: BaseAPI<APIRouter>, RefreshTokenRequestable {
    func refreshToken(_ token: String) -> AnyPublisher<AuthorizeModel?, APIError> {
        self.fetchData(target: .refreshToken(token: token), resonseseType: AuthorizeModel.self)
    }
}

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private var refreshUseCase: RefreshTokenRequest
    
    @Atomic private var isRefreshing = false
    
    private var disposeBag = DisposeBag()
    
    init(refreshUseCase: RefreshTokenRequest = RefreshTokenRequest(),
         isRefreshing: Bool = false) {
        self.refreshUseCase = refreshUseCase
        self.isRefreshing = isRefreshing
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.response,
              response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        if !isRefreshing {
            isRefreshing = true
            refreshToken()
        }
    }
    
    private func refreshToken() {
        refreshUseCase.refreshToken("")
            .sink { result in
                switch result {
                case .finished:
                    print("finish")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { data in
                if let data = data {
                    print(data)
                }
            }
            .store(in: disposeBag)
    }
}
