//
//  AppMonitor.swift
//  Base-ios
//
//  Created by Thân Văn Thanh on 24/01/2024.
//

import Foundation

import Alamofire

final class AppMonitor: EventMonitor {
    
    let queue = DispatchQueue(label: "com.thanhthan.networklogger")
    
    func requestDidResume(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidResume \(Date()) \(request.id)")
        }
    }
    
    func requestDidFinish(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidFinish \(Date()) \(request.id)")
        }
    }
    
    func requestDidCancel(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidCancel \(Date()) \(request.id)")
        }
    }
    
    func requestDidSuspend(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidSuspend \(Date()) \(request.id)")
        }
    }
    
    func requestIsRetrying(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestIsRetrying \(Date()) \(request.id)")
        }
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        if Configs.shared.loggingAPIEnabled {
            if let value = response.value {
                LogInfo("didParseResponse \(Date()) \(request.id) \(response.metrics?.taskInterval.duration ?? 0) \(value)")
            }
        }
    }
}
