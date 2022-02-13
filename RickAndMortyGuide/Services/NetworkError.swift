//
//  NetworkError.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case unreachableAddress(url: URL)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .unreachableAddress(let url):
            return "\(url.absoluteURL) is unreachable"
        case .invalidResponse:
            return "Response with mistake"
        }
    }
}
