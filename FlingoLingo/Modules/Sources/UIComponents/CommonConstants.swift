//
//  CommonConstants.swift
//
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import UIKit

public enum CommonConstants {

    public static let bigSpacing: CGFloat = 25
    public static let smallSpacing: CGFloat = 15

    // Скругление плашек и кнопки.
    public static let cornerRadius: CGFloat = 19

    // Расстояние в маленьких стеках.
    public static let smallStackSpacing: CGFloat = 5
    public static let bottomPadding: CGFloat = 40

    // Скругление полей ввода.
    public static let textFieldCornerRadius: CGFloat = 10

    // Значение safeAreaInsets.top.
    public static let safeAreaInsetsTop: CGFloat = {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }()

    // Высота текстового поля поиска.
    public static let textFieldHeight: CGFloat = 45

    // Высота кнопки.
    public static let buttonHeight: CGFloat = 60

    // Высота кнопки в навигации.
    public static let navigationBarIconSide: CGFloat = 17
}
