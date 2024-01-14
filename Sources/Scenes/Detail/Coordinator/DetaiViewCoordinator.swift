//
//  DetaiCoordinator.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation

class DetailViewCoordinator: Coordinator {
    
    static let shared = DetailViewCoordinator()
    
    func start(data: Any?) {
        guard let data = data as? SearchModel else { return }
        let vc = DetailViewController()
        vc.viewModel = DetailViewModel(repo: data)
        vc.getRootViewController().navigationController?.pushViewController(vc, animated: true)
    }
}
