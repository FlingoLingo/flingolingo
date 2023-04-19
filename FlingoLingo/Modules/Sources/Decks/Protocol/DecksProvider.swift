//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 19.04.2023.
//

import Foundation

public protocol DecksProvider: AnyObject {

    func getAllDecks(onFinish: @escaping (Result<[Deck], Error>) -> Void)

    func getDeck(id: Int, onFinish: @escaping (Result<Deck, Error>) -> Void)

    func createNewDeck(name: String, onFinish: @escaping (Result<Deck, Error>) -> Void)

    func deleteDeck(id: Int, onFinish: @escaping (Result<Deck, Error>) -> Void)

    func deleteCardFromDeck(deckId: Int, carId: Int, onFinish: @escaping (Bool) -> Void)

    func insertCardToDeck(onFinish: @escaping (Bool) -> Void)

    func editDeck(id: Int, newName: String, onFinish: @escaping (Result<Deck, Error>) -> Void)
}
