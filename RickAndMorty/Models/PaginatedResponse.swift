//
//  PaginatedResponse.swift
//  RickAndMorty
//
//  Created by Diplomado on 02/12/23.
//

import Foundation

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct PaginatedResponse<T: Codable>: Codable {
    let info: PageInfo
    let results: [T]
}
