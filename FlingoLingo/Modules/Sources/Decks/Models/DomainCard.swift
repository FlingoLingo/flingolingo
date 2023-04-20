//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import NetworkLayer

public struct DomainCard: Identifiable {
    public let id: Int
    public let eng: String
    public let rus: String
    public let examples: String

    public init(card: Card) {
        self.id = card.id
        self.rus = card.rus
        self.eng = card.eng
        self.examples = card.examples
    }
}
