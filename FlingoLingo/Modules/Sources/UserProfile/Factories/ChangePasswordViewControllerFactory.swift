import SwiftUI
import UIKit
import Authorization

public struct ChangePasswordViewControllerFactory {

    public init() {

    }

    public func changePasswordViewController(user: User, backAction: @escaping () -> Void, provider: ProfileProvider) -> UIViewController {
        let viewModel = ChangePasswordViewModel(user: user, backAction: backAction, provider: provider)
        return UIHostingController(rootView: ChangePasswordView(viewModel: viewModel))
    }
}
