//
//  SearchViewModel.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    let getSearchData: SearchServiceProtocol
    
    init(getSearchData: SearchServiceProtocol) {
        self.getSearchData = getSearchData
    }
}

extension SearchViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let searchTrigger: Driver<String>
        let selectUserTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let searchResponse: Driver<ItemSearchResponse>
    }
    
    
    func transform(_ input: Input) -> Output {
        let searchResponse = input.searchTrigger
            .flatMapLatest { [weak self] username -> Driver<ItemSearchResponse> in
                guard let self = self else { return .empty() }
                return self.getSearchData.search(username: username)
                    .trackActivity(self.loading)
                    .trackError(self.error)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(searchResponse: searchResponse)
    }
}
