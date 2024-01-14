//
//  AlamofireLogger.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Foundation
import Alamofire

final class AlamofireLogger: EventMonitor {
    
    func requestDidResume(_ request: Request) {
        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description} } ?? ""
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "{}"
        let message = """
        \n┌🚀🚀🚀🚀🚀
        | Request Started: \(request)
        | Body Data: \(body)
        |Headers:\n \(allHeaders)
        └🚀🚀🚀🚀🚀🚀
        """
        
        NSLog(message)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        
        NSLog("\n⚡️⚡️⚡️⚡️ Response Receivedad: \(response.debugDescription)")
        switch response.result {
            case .success:
                if let body = response.data {
                    print("┌✅✅✅✅✅")
                    let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
                    print("\n ℹ️ℹ️ℹ️ Response String: \(bodyString)\n")
                    print(
                        "└✅✅✅✅✅")
                }
            case .failure(let error):
                logError(body: error,
                         statusCode: response.response?.statusCode ?? 0,
                         method: response.request?.method?.rawValue ?? "",
                         url: response.request?.url?.absoluteString ?? "")
                
        }
        // print("\n⚡️⚡️⚡️⚡️ Response All Headers: \(String(describing: response.response?.allHeaderFields))")
        
    }
    
    private func logError(body: AFError, statusCode: Int, method: String, url: String) {
            print(
                "┌❌ ❌ ❌ ❌ ❌")
            print(
               """
               | Time: \(Date())
               | Endpoint: \(method) \(url)
               | Error [code: \(statusCode)]: \(body)
               """
            )
            print(
                "└❌ ❌ ❌ ❌ ❌")
        }
}
