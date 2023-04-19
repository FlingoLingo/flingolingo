import SwiftUI
import UIKit

public struct ProfileViewControllerFactory {

    public init() {

    }

    public func profileViewController() -> UIViewController {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(user: User(), router: router)
        let controller = UIHostingController(rootView: ProfileView(viewModel: viewModel))
        router.presentingViewController = controller
        return controller
    }
}
