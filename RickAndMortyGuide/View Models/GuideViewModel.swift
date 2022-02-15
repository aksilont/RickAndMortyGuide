//
//  GuideViewModel.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 15.02.2022.
//

import Foundation
import Combine

final class GuideViewModel: ObservableObject {
    // Input
    @Published var indexEndpoint: Int = 1
    
    // Output
    @Published var characters: [Character] = []
    @Published var locations: [Location] = []
    @Published var episodes: [Episode] = []
    
    private let apiCLient = APIClient()
    private var cancellable = Set<AnyCancellable>()
    
    func fetchCharacters() {
        apiCLient.fetch(url: Endpoint.characters.url)
            .map { (response: CharactersResponse) -> [Character] in
                response.results
            }
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { [unowned self] data in
                characters = data
            }
            .store(in: &cancellable)
    }
    
    func fetchLocations() {
        apiCLient.fetch(url: Endpoint.locations.url)
            .map { (response: LocationsResponse) -> [Location] in
                response.results
            }
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { [unowned self] data in
                locations = data
            }
            .store(in: &cancellable)
    }
    
    func fetchEpisodes() {
        apiCLient.fetch(url: Endpoint.episodes.url)
            .map { (response: EpisodesResponse) -> [Episode] in
                response.results
            }
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { [unowned self] data in
                episodes = data
            }
            .store(in: &cancellable)
    }
    
    init() {
        $indexEndpoint
            .sink(receiveValue: { [unowned self] index in
                switch index {
                case 1: fetchCharacters()
                case 2: fetchLocations()
                case 3: fetchEpisodes()
                default: fetchCharacters()
                }
            })
            .store(in: &cancellable)
    }
    
    deinit {
        for item in cancellable {
            item.cancel()
        }
    }
    
}
