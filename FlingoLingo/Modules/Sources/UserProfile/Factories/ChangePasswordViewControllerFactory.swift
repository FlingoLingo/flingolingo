import SwiftUI
import UIKit

public struct ChangePasswordViewControllerFactory {
    @ObservedObject private var viewModel = UsersViewModel()

    public init() {

    }

    public func changePasswordViewController() -> UIViewController {
        return UIHostingController(rootView: ChangePasswordView(viewModel: viewModel))
    }
}
