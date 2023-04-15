import SwiftUI
import UIKit

class UserProfileViewControllerFactory {
    @ObservedObject private var viewModel = UsersViewModel()

    public init() {

    }

    public func userProfileViewController() -> UIViewController {
        return UIHostingController(rootView: UserProfileView(viewModel: self.viewModel))
    }
}
