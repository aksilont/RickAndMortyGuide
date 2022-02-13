//
//  APIClient.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation
import Combine

struct APIClient {
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    func fetchCharacterWith(_ id: Int) -> AnyPublisher<Character, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Endpoint.character(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Character.self, decoder: decoder)
            .mapError { error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Endpoint.character(id).url)
                default:
                    return NetworkError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchLocationWith(_ id: Int) -> AnyPublisher<Location, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Endpoint.location(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Location.self, decoder: decoder)
            .mapError { error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Endpoint.location(id).url)
                default:
                    return NetworkError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchEpisodeWith(_ id: Int) -> AnyPublisher<Episode, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Endpoint.episode(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Episode.self, decoder: decoder)
            .mapError { error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Endpoint.episode(id).url)
                default:
                    return NetworkError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
}
