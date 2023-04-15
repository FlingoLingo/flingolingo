//
//  DeckViewControllerFactory.swift
//  
//
//  Created by Алиса Вышегородцева on 15.04.2023.
//

import Foundation
import UIKit
import SwiftUI

public struct DeckViewControllerFactory {

    public init() {

    }

    public func deckViewController(deck: Deck) -> UIViewController {
        let viewModel = DeckViewModel(deck: deck)
        return UIHostingController(rootView: DeckView(viewModel: viewModel))
    }
}
