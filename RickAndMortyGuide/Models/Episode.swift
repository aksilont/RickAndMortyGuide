//
//  Episode.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
    let url: String
}
