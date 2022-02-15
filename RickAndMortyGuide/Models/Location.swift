//
//  Location.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

struct LocationsResponse: Codable {
    let info: LocationsPageInfo
    let results: [Location]
}

// MARK: - Info
struct LocationsPageInfo: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Location: Codable, Identifiable {
    var id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String
}
