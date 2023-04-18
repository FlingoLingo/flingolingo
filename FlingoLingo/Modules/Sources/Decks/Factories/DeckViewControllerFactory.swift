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

    public func deckViewController(deck: Deck, backAction: @escaping () -> Void) -> UIViewController {
        let viewModel = DeckViewModel(deck: deck, backAction: backAction)
        return UIHostingController(rootView: DeckView(viewModel: viewModel))
    }
}
