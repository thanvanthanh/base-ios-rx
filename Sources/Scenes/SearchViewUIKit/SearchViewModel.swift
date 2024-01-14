//
//  SearchViewModel.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Combine
import Foundation

class SearchViewModel: BaseViewModel {
    let getSearchData: SearchServiceProtocol
    
    init(getSearchData: SearchServiceProtocol) {
        self.getSearchData = getSearchData
    }
}

extension SearchViewModel: ViewModelType {
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
        let searchTrigger: AnyPublisher<String, Never>
        let selectUserTrigger: AnyPublisher<IndexPath, Never>
    }
    
    final class Output: ObservableObject {
        @Published var response: ItemSearchResponse?
        @Published var isLoading = false
        @Published var error: Error?
    }
    
    func transform(_ input: Input, _ disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.loadTrigger
            .flatMap {
                self.getSearchData
                    .search(username: "thanvanthanh")
                    .trackError(self.errorIndicator)
                    .trackActivity(self.activityIndicator)
                    .eraseToAnyPublisher()
            }
            .assign(to: \.response, on: output)
            .store(in: disposeBag)
        
        input.searchTrigger
            .flatMap {
                self.getSearchData
                    .search(username: $0)
                    .trackError(self.errorIndicator)
                    .trackActivity(self.activityIndicator)
                    .eraseToAnyPublisher()
            }
            .assign(to: \.response, on: output)
            .store(in: disposeBag)
        
        input.selectUserTrigger
            .sink {
                let user = output.response?.items?[$0.row]
                DetailViewCoordinator.shared.start(data: user)
            }
            .store(in: disposeBag)
        
        return output
    }
}
