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
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .print("fetching")
            .mapError { error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: url)
                default:
                    return NetworkError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCharacters() -> AnyPublisher<[Character], NetworkError> {
        return fetch(url: Endpoint.characters.url)
            .map { (response: CharactersResponse) -> [Character] in
                response.results
            }
            .eraseToAnyPublisher()
    }
    
    func fetchLocations() -> AnyPublisher<[Location], NetworkError> {
        fetch(url: Endpoint.locations.url)
            .map { (response: LocationsResponse) -> [Location] in
                response.results
            }
            .eraseToAnyPublisher()
    }
    
    func fetchEpisodes() -> AnyPublisher<[Episode], NetworkError> {
        fetch(url: Endpoint.episodes.url)
            .map { (response: EpisodesResponse) -> [Episode] in
                response.results
            }
            .eraseToAnyPublisher()
    }
    
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
