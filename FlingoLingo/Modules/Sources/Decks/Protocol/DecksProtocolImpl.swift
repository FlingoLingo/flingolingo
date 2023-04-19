//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 19.04.2023.
//

import Foundation

public class DecksProtocolImpl: DecksProvider {

    public init() {

    }

    public func getAllDecks(onFinish: @escaping (Result<[Deck], Error>) -> Void) {

    }

    public func getDeck(id: Int, onFinish: @escaping (Result<Deck, Error>) -> Void) {

    }

    public func createNewDeck(name: String, onFinish: @escaping (Result<Deck, Error>) -> Void) {

    }

    public func deleteDeck(id: Int, onFinish: @escaping (Result<Deck, Error>) -> Void) {

    }

    public func deleteCardFromDeck(deckId: Int, carId: Int, onFinish: @escaping (Bool) -> Void) {

    }

    public func insertCardToDeck(onFinish: @escaping (Bool) -> Void) {

    }

    public func editDeck(id: Int, newName: String, onFinish: @escaping (Result<Deck, Error>) -> Void) {

    }
}
