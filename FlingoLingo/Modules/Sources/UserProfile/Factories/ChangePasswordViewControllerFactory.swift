import SwiftUI
import UIKit

public struct ChangePasswordViewControllerFactory {

    public init() {

    }

    public func changePasswordViewController(viewModel: UserViewModel) -> UIViewController {
        return UIHostingController(rootView: ChangePasswordView(viewModel: viewModel))
    }
}
