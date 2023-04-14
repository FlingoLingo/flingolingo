//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import SwiftUI

public enum SFonts {
    
    // Верхний большой заголовок.
    public static let largeTitle = Font(UIFont.systemFont(ofSize: 32, weight: .bold))
    // Подзаголовок.
    public static let subtitle = Font(UIFont.systemFont(ofSize: 22, weight: .semibold))
    // Кнопка.
    public static let buttonTitle = Font(UIFont.systemFont(ofSize: 20, weight: .semibold))
    // Заголовки на плашках.
    public static let cardsTitle = Font(UIFont.systemFont(ofSize: 17, weight: .semibold))
    // Текст в поиске.
    public static let searchText = Font(UIFont.systemFont(ofSize: 17, weight: .regular))
    // Основной текст.
    public static let mainText = Font(UIFont.systemFont(ofSize: 15, weight: .regular))
    // Текст на плашках.
    public static let cardsText = Font(UIFont.systemFont(ofSize: 13, weight: .regular))
}
