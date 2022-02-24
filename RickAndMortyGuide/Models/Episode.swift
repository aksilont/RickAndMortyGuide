//
//  Episode.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

struct EpisodesResponse: Codable {
    let info: EpisodesPageInfo?
    let results: [Episode]
}

// MARK: - Info
struct EpisodesPageInfo: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Episode: Codable, Identifiable {
    let id: Int
    let name, episode: String
    let characters: [String]
    let url: String
}
