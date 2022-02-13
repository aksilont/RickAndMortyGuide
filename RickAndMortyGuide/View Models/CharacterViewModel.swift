//
//  CharacterViewModel.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    // Input
    @Published var id: String = "1"
    
    // Output
    @Published var character: Character?
    
    private let apiClient = APIClient()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $id
            .map { stringId in
                if let id = Int(stringId) { return id }
                else { return 1 }
            }
            .flatMap { index -> AnyPublisher<Character, NetworkError> in
                return self.apiClient.fetchCharacterWith(index)
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }) { [unowned self] value in
                self.character = value
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        for item in subscriptions {
            item.cancel()
        }
    }
}
