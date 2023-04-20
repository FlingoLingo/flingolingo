//
//  DecksViewControllerFactory.swift
//  
//
//  Created by Алиса Вышегородцева on 15.04.2023.
//

import Foundation
import UIKit
import SwiftUI

public struct DecksViewControllerFactory {

    public init() {

    }

    public func decksViewController(provider: DecksProvider) -> UIViewController {
        let router = DecksRouter()
        let viewModel = DecksViewModel(router: router, provider: provider)
        let controller = UIHostingController(rootView: DecksPageView(viewModel: viewModel))
        router.presentingViewController = controller
        return controller
    }
}
