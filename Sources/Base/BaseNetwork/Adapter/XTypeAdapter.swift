//
//  XTypeAdapter.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 24/01/2024.
//

import Foundation
import Alamofire

final class XTypeAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(name: "X-Type", value: "iOS")
        completion(.success(urlRequest))
    }
}
