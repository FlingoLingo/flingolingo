//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public struct Card: Identifiable {
    public let id: Int
    public let eng: String
    public let rus: String
    public let examples: [String]
    
    public init(id: Int, eng: String, rus: String, examples: [String]) {
        self.id = id
        self.rus = rus
        self.eng = eng
        self.examples = examples
    }
}
