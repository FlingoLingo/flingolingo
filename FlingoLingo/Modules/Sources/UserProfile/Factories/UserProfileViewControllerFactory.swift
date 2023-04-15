import SwiftUI
import UIKit

public struct UserProfileViewControllerFactory {

    public init() {

    }

    public func userProfileViewController(viewModel: UserViewModel) -> UIViewController {
        return UIHostingController(rootView: UserProfileView(viewModel: viewModel))
    }
}
