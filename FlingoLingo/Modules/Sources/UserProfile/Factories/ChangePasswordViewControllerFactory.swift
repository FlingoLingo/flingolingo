import SwiftUI
import UIKit

public struct ChangePasswordViewControllerFactory {

    public init() {

    }

    public func changePasswordViewController(user: User) -> UIViewController {
        let viewModel = UserViewModel(user: user)
        return UIHostingController(rootView: ChangePasswordView(viewModel: viewModel))
    }
}
