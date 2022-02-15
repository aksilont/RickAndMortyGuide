//
//  Endpoint.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

enum Endpoint {
    case characters
    case locations
    case episodes
    case character(Int)
    case location(Int)
    case episode(Int)
    
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    var url: URL {
        switch self {
        case .characters:
            return Endpoint.baseURL.appendingPathComponent("character")
        case .locations:
            return Endpoint.baseURL.appendingPathComponent("location")
        case .episodes:
            return Endpoint.baseURL.appendingPathComponent("episode")
        case .character(let id):
            return Endpoint.baseURL.appendingPathComponent("character/\(id)")
        case .location(let id):
            return Endpoint.baseURL.appendingPathComponent("location/\(id)")
        case .episode(let id):
            return Endpoint.baseURL.appendingPathComponent("episode/\(id)")
        }
    }
}
