//
//  AFNetworking.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Alamofire
import Foundation
import UIKit


final class AFNetworking: Alamofire.Session {
    static let shared: AFNetworking = {
        return AFNetworking(interceptor: RequestInterceptor(), eventMonitors: [AlamofireLogger()])
    }()
    
    private(set) var networkEnable = true
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: Configs.share.env.hostName)
    
    func listenForReachability() {
        guard let reachabilityManager = reachabilityManager else {
            return
        }
        networkEnable = reachabilityManager.isReachable
        
        reachabilityManager.startListening { status in
            switch status {
            case .notReachable:
                self.networkEnable = false
                self.showNetworkFailureAlert()
            case .unknown, .reachable:
                fallthrough
            @unknown default:
                self.networkEnable = true
            }
        }
    }
    
    func showNetworkFailureAlert() {
        guard let rootVC = UIApplication.shared.mainKeyWindow?.rootViewController else { return }
        Alert(title: "Can not connect to server.", message: "This may be a temporary failure or a network issue. Please try again later.")
            .action(.ok) {
                return
            }.show(on: rootVC)
    }
}
