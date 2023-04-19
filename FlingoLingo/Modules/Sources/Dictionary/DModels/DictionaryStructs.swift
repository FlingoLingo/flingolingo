//
//  DictionaryStructs.swift
//  FlingoLingo
//
//  Created by Yandex on 14.04.2023.
//

import Foundation

// swiftlint:disable identifier_name
// swiftlint:disable type_name

typealias Langs = [String]

// MARK: - Words
struct Word: Codable {
    let def: [Def]?
}

// MARK: - Def
struct Def: Codable {
    let text, pos, ts: String?
    let tr: [Tr]?
}

// MARK: - Tr
struct Tr: Codable {
    let text, pos, gen: String?
    let fr: Int?
    let syn: [Syn]?
    let mean: [Mean]?
    let asp: String?
    let ex: [Ex]?
}

struct Ex: Codable {
    let text: String?
    let tr: [Mean]?
}

// MARK: - Mean
struct Mean: Codable {
    let text: String?
}

// MARK: - Syn
struct Syn: Codable {
    let text, pos, gen: String?
    let fr: Int?
    let asp: String?
}

// MARK: - Head
struct Head: Codable {
}
