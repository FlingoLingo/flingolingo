import SwiftUI
import UIKit

public struct ChangePasswordViewControllerFactory {

    public init() {

    }

    public func changePasswordViewController(user: User, backAction: @escaping () -> Void) -> UIViewController {
        let viewModel = UserViewModel(user: user, backAction: backAction, isGuest: false)
        return UIHostingController(rootView: ChangePasswordView(viewModel: viewModel))
    }
}
