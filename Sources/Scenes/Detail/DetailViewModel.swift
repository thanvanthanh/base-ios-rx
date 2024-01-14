//
//  DetailViewModel.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import Combine

class DetailViewModel: BaseViewModel {
    let useCase: RepositoryDetailUseCase
    let repo: SearchModel
    
    init(useCase: RepositoryDetailUseCase = RepositoryDetailUseCase(),
         repo: SearchModel) {
        self.useCase = useCase
        self.repo = repo
    }
}

extension DetailViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
    }
    
    final class Output: ObservableObject {
        @Published var detail: SearchModel?
    }
    
    func transform(_ input: Input, _ disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loadTrigger
            .map { self.repo }
            .assign(to: \.detail, on: output)
            .store(in: disposeBag)
        return output
    }
}
