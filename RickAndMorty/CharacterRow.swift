//
//  CharacterRow.swift
//  RickAndMorty
//
//  Created by Diplomado on 01/12/23.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text(character.name)
                    .font(.system(size: 18, design: .rounded))
                Spacer()
            Text(character.species)
                .font(.system(size: 16, weight: .thin, design: .rounded))
        }
    }
}

#Preview {
    CharacterRow(character: Character(id: 1, name: "Rick Sanchez", species: "Human"))
}
