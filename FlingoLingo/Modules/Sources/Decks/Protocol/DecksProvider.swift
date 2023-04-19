//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 19.04.2023.
//

import Foundation
import NetworkLayer

public protocol DecksProvider: AnyObject {

    func getAllDecks(onFinish: @escaping (Result<[DeckResponse], ClientError>) -> Void)

    func getDeck(id: Int, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void)

    func createNewDeck(name: String, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void)

    func deleteDeck(id: Int, onFinish: @escaping (Result<MessageResponse, ClientError>) -> Void)

    func deleteCardFromDeck(deckId: Int, carId: Int, onFinish: @escaping (Result<MessageResponse, ClientError>) -> Void)

    func insertCardToDeck(onFinish: @escaping (Bool) -> Void)

    func editDeck(id: Int, newName: String, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void)
}
