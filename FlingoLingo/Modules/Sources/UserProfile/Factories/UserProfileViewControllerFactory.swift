import SwiftUI
import UIKit

public struct UserProfileViewControllerFactory {

    public init() {

    }

    public func userProfileViewController(viewModel: UserViewModel) -> UIViewController {
        let router = UserProfileRouter()
        let viewModel = UserViewModel(router: router)
        let controller = UIHostingController(rootView: UserProfileView(viewModel: viewModel))
        router.presentingViewController = controller
        return controller
    }
}
