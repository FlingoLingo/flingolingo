//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 15.04.2023.
//

import Foundation
import UIKit

public final class DecksRouter {

    public weak var presentingViewController: UIViewController?

    public init() {

    }

    func viewDetails(deck: Deck, provider: DecksProvider) {
        let deckFactory = DeckViewControllerFactory()
        let deckController = deckFactory.deckViewController(deck: deck,
                                                            backAction: goBack,
                                                            provider: provider)
        presentingViewController?.navigationController?.pushViewController(deckController, animated: true)
    }

    private func goBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
