//
//  File.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import Foundation
import UIKit

final class CardsRouter {

    public weak var presentingViewController: UIViewController?

    public init() {

    }

    func startLearning(deck: DomainDeck, provider: DecksProvider) {
        let cardFactory = CardsViewControllerFactory()
        let cardsController = cardFactory.cardsViewController(
            deck: deck,
            provider: provider,
            backAction: goBack,
            popToRootAction: popToRoot
        )
        presentingViewController?.navigationController?.pushViewController(cardsController, animated: true)
    }

    private func goBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }

    private func popToRoot() {
        presentingViewController?.navigationController?.popToRootViewController(animated: true)
    }
}
