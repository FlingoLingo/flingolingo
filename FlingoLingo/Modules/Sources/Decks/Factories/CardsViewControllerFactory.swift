//
//  File.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import Foundation
import UIKit
import SwiftUI

public struct CardsViewControllerFactory {

    public init() {

    }

    public func cardsViewController(
        deck: Deck,
        backAction: @escaping () -> Void,
        popToRootAction: @escaping () -> Void
    ) -> UIViewController {
        let viewModel = CardsViewModel(deck: deck, backAction: backAction, popToRootAction: popToRootAction)
        return UIHostingController(rootView: CardsView(viewModel: viewModel))
    }
}
