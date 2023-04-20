import SwiftUI
import UIKit
import Authorization

public struct ProfileViewControllerFactory {

    public init() {

    }

    public func profileViewController(provider: ProfileProvider) -> UIViewController {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(router: router, provider: provider)
        let controller = UIHostingController(rootView: ProfileView(viewModel: viewModel))
        router.presentingViewController = controller
        return controller
    }
}
