//
//  SearchViewCoordinator.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit

final class SearchViewCoordinator: Coordinator {
    static let shared = SearchViewCoordinator()
    func start(data: Any?) {
        guard let window = data as? UIWindow else { return }
        let vc = SearchViewController()
        vc.viewModel = SearchViewModel(getSearchData: SearchRequest())
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
