//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public class DecksViewModel: ObservableObject {
    
    @Published var decks: [Deck]
    
    public init(decks: [Deck]) {
        self.decks = decks
    }
    
    func deckCardCLicked(id: Int) {
        
    }
}
