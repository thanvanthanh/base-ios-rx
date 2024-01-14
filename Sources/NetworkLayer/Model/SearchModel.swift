//
//  SearchModel.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Foundation

class ItemSearchResponse: Codable, Identifiable {
    var totalCount: Int?
    var items: [SearchModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
}

struct SearchModel: Codable, Identifiable {
    let id: Int
    let avatarUrl: String
    let htmlUrl: URL
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}

extension SearchModel: Equatable {
    static func == (lhs: SearchModel, rhs: SearchModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension SearchModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(login)
    }
}

