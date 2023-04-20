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

    public func deckViewController(deck: DomainDeck,
                                   backAction: @escaping () -> Void,
                                   provider: DecksProvider)
    -> UIViewController {
        let router = CardsRouter()
        let viewModel = DeckViewModel(deck: deck, provider: provider, backAction: backAction, router: router)
        let controller = UIHostingController(rootView: DeckView(viewModel: viewModel))
        controller.hidesBottomBarWhenPushed = true
        router.presentingViewController = controller
        return controller
    }
}
