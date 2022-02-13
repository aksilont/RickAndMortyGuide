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
    @State var segmentIndex: Int = 1
    
    var body: some View {
        VStack {
            Text("Rick&Morty Guide")
                .font(.title)
            Picker("", selection: $segmentIndex) {
                Text("Characters").tag(1)
                Text("Locations").tag(2)
                Text("Episodes").tag(3)
            }
            .padding(.horizontal, 5)
            .pickerStyle(.segmented)
            if segmentIndex == 1 {
                charactersView
            }
            Spacer()
        }
    }
    
    var charactersView: some View {
        return VStack {
            TextField("Введите id персонажа", text: $characterViewModel.id)
                .padding(.horizontal, 5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                .padding([.leading, .trailing])
                .keyboardType(.numberPad)
            HStack {
                Text(characterViewModel.character?.description ?? "")
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
