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

    @ObservedObject private var viewModel = DecksViewModel()

    public init() {

    }

    public func decksViewController() -> UIViewController {
        return UIHostingController(rootView: DecksPageView(viewModel: viewModel))
    }
}
