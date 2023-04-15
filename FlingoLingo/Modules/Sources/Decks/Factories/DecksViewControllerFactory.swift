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

    public func decksViewController(viewModel: DecksViewModel) -> UIViewController {
        return UIHostingController(rootView: DecksPageView(viewModel: viewModel))
    }
}
