//
//  SearchUseCase.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Foundation
import RxSwift
import Moya

protocol SearchServiceProtocol: AnyObject {
    func search(username: String) -> Single <ItemSearchResponse>
}

class SearchRequest: SearchServiceProtocol {
    
    private var api = ApiProvider()
    
    func search(username: String) -> Single<ItemSearchResponse> {
        let route = APIRouter.search(username: username)
        return api.request(route: route, type: ItemSearchResponse.self)
    }
}
