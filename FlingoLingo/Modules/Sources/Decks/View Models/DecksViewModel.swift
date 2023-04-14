//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public final class DecksViewModel: ObservableObject {
    
    @Published var decks: [Deck] = []
    
    public init() {
        
    }
    
    func deckCardClicked(id: Int) {
        
    }
}
