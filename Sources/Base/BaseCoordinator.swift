//
//  BaseCoordinator.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation

protocol Coordinator: AnyObject {
    func start(data: Any?)
}

extension Coordinator {
    func start(data: Any? = nil) {
        self.start(data: nil)
    }
}
