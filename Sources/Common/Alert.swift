//
//  Alert.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 31/08/2023.
//

import Foundation
import UIKit

typealias AlertCompletion = () -> Void
typealias AlertHandler = (Bool) -> Void

enum AlertAction {
    case cancel
    case ok
    case other(String)

    func title() -> String {
        switch self {
        case .cancel: return "Cancel"
        case .ok: return "Ok"
        case .other(let title): return title
        }
    }

    func style() -> UIAlertAction.Style {
        switch self {
        case .cancel: return .cancel
        case .ok: return .default
        case .other(_): return .default
        }
    }
}

class Alert {
    private var alertController: UIAlertController

    convenience init(message: String?) {
        self.init(title: "", message: message)
    }

    init(title: String?, message: String?) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    func action(_ action: AlertAction, handler: AlertCompletion? = nil) -> Self {
        let action = UIAlertAction(title: action.title(), style: action.style(), handler: { _ in
            handler?()
        })
        alertController.addAction(action)
        return self
    }

    func show(on viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.present(self.alertController, animated: true, completion: nil)
        }
    }

    func dismiss(animated: Bool = true) {
        alertController.dismiss(animated: animated)
    }

    static func showConfirm(on viewController: UIViewController, message: String?, handler: AlertCompletion? = nil) {
        Alert(message: message)
            .action(.ok) {
                handler?()
            }
            .show(on: viewController)
    }

    static func showOKHandler(on viewController: UIViewController, message: String?, handler: AlertCompletion? = nil) {
        Alert(message: message)
            .action(.other("No"))
            .action(.other("Yes")) {
                handler?()
            }
            .show(on: viewController)
    }

    static func showOKCancelHandler(on viewController: UIViewController, message: String?, handler: AlertHandler? = nil) {
        Alert(message: message)
            .action(.other("No")) {
                handler?(false)
            }
            .action(.other("Yes")) {
                handler?(true)
            }
            .show(on: viewController)
    }
}
