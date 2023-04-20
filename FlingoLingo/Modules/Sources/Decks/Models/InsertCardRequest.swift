//
//  File.swift
//  
//
//  Created by Yandex on 20.04.2023.
//

import Foundation

public struct InsertCardRequest {
    public let eng: String
    public let rus: String
    public let transcription: String
    public let examples: String
    public let decks: [Int]
    public init(eng: String, rus: String, transcription: String, examples: String, decks: [Int]) {
        self.eng = eng
        self.rus = rus
        self.transcription = transcription
        self.examples = examples
        self.decks = decks
    }
}
