//
//  MainView.swift
//  RickAndMortyGuide
//
//  Created by Aksilont on 13.02.2022.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    @ObservedObject var guideViewModel = GuideViewModel()
    @State var selectedIndex: Int = 1
    
    var body: some View {
        VStack {
            Text("Rick&Morty Guide")
                .font(.title)
            
            Picker("", selection: $guideViewModel.indexEndpoint) {
                Text("Characters").tag(1)
                Text("Locations").tag(2)
                Text("Episodes").tag(3)
            }
            .padding(.horizontal, 5)
            .pickerStyle(.segmented)
            
            List {
                switch guideViewModel.indexEndpoint {
                case 1:
                    ForEach(guideViewModel.characters) { item in
                        Text(item.name)
                    }
                case 2:
                    ForEach(guideViewModel.locations) { item in
                        Text(item.name ?? "")
                    }
                case 3:
                    ForEach(guideViewModel.episodes) { item in
                        Text(item.name)
                    }
                default:
                    Text("No data")
                    Spacer()
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
