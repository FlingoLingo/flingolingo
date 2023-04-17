import SwiftUI
import UIKit

public struct GuestProfileViewControllerFactory {

    public init() {

    }

    public func changePasswordViewController() -> UIViewController {
        return UIHostingController(rootView: GuestProfileView(viewModel: UserViewModel()))
    }
}
