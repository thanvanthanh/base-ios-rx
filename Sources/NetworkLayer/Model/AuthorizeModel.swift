//
//  AuthorizeModel.swift
//  mvvm-combine-uikit
//
//  Created by Thân Văn Thanh on 31/08/2023.
//

import Foundation

struct AuthorizeModel: Codable {
    var accessToken: String?
    var refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
