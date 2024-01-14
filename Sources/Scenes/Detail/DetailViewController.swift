//
//  DetailViewController.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import UIKit
import Combine
import SDWebImage

final class DetailViewController: BaseViewController {

    @IBOutlet private  weak var nameTitle: UILabel!
    @IBOutlet private weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewmodel = viewModel as? DetailViewModel else { return }
        
        let input = DetailViewModel.Input(loadTrigger: Just(()).eraseToAnyPublisher())
        let output = viewmodel.transform(input, disposeBag)
        
        output.$detail.subscribe(detailSubscriber)
    }

}

extension DetailViewController {
    private var detailSubscriber: Binder<SearchModel?> {
        Binder(self) { vc, data in
            vc.nameTitle.text = data?.login
            vc.avatarImage.sd_setImage(with: URL(string: data?.avatarUrl ?? ""))
        }
    }
}
