//
//  Endpoint.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

enum Endpoint {
    case character(Int)
    case location(Int)
    case episode(Int)
    
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    var url: URL {
        switch self {
        case .character(let id):
            return Endpoint.baseURL.appendingPathComponent("character/\(id)")
        case .location(let id):
            return Endpoint.baseURL.appendingPathComponent("location/\(id)")
        case .episode(let id):
            return Endpoint.baseURL.appendingPathComponent("episode/\(id)")
        }
    }
}
