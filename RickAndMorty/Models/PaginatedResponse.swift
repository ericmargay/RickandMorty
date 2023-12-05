//
//  PaginatedResponse.swift
//  RickAndMorty
//
//  Created by Eric Margay on 02/12/23.
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    let info: Info
    let results: [T]

    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct APIEndpoints {
    static let character = "/api/character/"
}

