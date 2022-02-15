//
//  Character.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

struct CharactersResponse: Codable {
    let info: CharactersPageInfo
    let results: [Character]
}

// MARK: - Info
struct CharactersPageInfo: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable, Identifiable, CustomStringConvertible {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    
    var description: String {
        return """
        Name: \(name)
        Status: \(name)
        Species: \(species)
        Type: \(type)
        Gender: \(gender)
        """
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
