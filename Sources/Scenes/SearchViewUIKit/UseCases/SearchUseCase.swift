//
//  SearchUseCase.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Foundation
import Combine

protocol SearchServiceProtocol: AnyObject {
    func search(username: String) -> AnyPublisher <ItemSearchResponse?, APIError>
}

class SearchRequest: BaseAPI<APIRouter>, SearchServiceProtocol {
    func search(username: String) -> AnyPublisher<ItemSearchResponse?, APIError> {
        self.fetchData(target: .search(username: username), resonseseType: ItemSearchResponse.self)
    }
}
