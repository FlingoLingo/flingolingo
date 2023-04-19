import SwiftUI
import UIKit

public struct ProfileViewControllerFactory {

    public init() {

    }

    public func profileViewController() -> UIViewController {
        let router = ProfileRouter()
        let viewModel = UserViewModel(router: router, isGuest: false)
        let controller = UIHostingController(rootView: ProfileView(viewModel: viewModel))
        router.presentingViewController = controller
        return controller
    }
}
